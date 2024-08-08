#!/usr/bin/env ruby

require_relative "src/fault_tree.rb"
require_relative "src/print_visitor.rb"

# frozen_string_literal: true

# TLA-Robust -- a script for calculating robustness of TLA+ models.
# Given:
# -- A newline-separated list of fault action names
# -- A composed model
# -- The name of a safety property to evaluate robustness against.
# TLA-Robust will compute the maximum robustness with respect to the named faults.

# ***** HELPER FNS ***** #
def usage
  puts "USAGE:"
  puts "tla-robust [path to model] [name of invariant] [faults]"
end


# ***** PARSE ARGS ***** #

if ARGV.length != 3
  usage
  exit 1
end

modelpath = ARGV[0]
invname = ARGV[1]
faults = ARGV[2]


# ***** CONFIGURE FILES ***** #

Dir.mkdir("robust-data") unless File.exist?("robust-data")

# Write the config file for the invariant.
robustconfigpath = "robust-data/robust.cfg"
File.open(robustconfigpath, "w") { | f | f.write("SPECIFICATION Spec\nINVARIANT #{invname}") }

# Now, copy in the relevant data for the faults
modelname = "RobustModel"
robustmodelpath = "robust-data/#{modelname}.tla"

# Read in all the lines.
lines = File.readlines(modelpath)
# Must be at least two lines in a valid TLA+ model.
unless lines.length > 1
  puts "Error: invalid TLA+ model."
  exit 1
end
# Configure model to share modelname
lines[0] = "---- MODULE #{modelname} ----\n"

File.open(robustmodelpath, "w") { | f | f.write lines.join }


# ***** MODEL CHECKING ***** #

# Notice: ruby backticks not secure: https://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby
# Additionally, calling "system" preserves return code.
puts system "tlc", robustmodelpath, "-config", robustconfigpath