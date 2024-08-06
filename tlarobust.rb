#!/usr/bin/env ruby

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
  puts "tla-robust [path to model] [name of invariant]"
end

# ***** MAIN PROGRAM ***** #

if ARGV.length != 2
  usage
  exit 1
end

modelpath = ARGV[0]
invname = ARGV[1]

# Create directory for our file.
Dir.mkdir("robust-data") unless File.exist?("robust-data")

# Write the config file for the invariant.
File.open("robust-data/robust.cfg", "w") { | f | f.write("SPECIFICATION Spec\nINVARIANT #{invname}") }

# Notice: ruby backticks not secure: https://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby
# Additionally, calling "system" preserves return code.
puts system 'tlc', modelpath, '-config', 'robust-data/robust.cfg'

# Mechanism:
# Repeatedly write amended specs to end of model file.
# -- Notice: this serializes TLC calls. May need to spawn new process for this.


# # Once args are parsed, give to robustifier
# class Robustifier
#   def initialize(modelpath, invname)
#     @modelpath = modelpath
#     @invname = invname
#   end
# end


