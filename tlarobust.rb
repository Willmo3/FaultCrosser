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
  puts "tla-robust [path to model] [path to cfg file]"
end

# ***** MAIN PROGRAM ***** #

if ARGV.length != 2
  usage
  exit 1
end

modelpath = ARGV[0]
cfgname = ARGV[1]

puts `tlc #{modelpath} -config #{cfgname}`




# # Once args are parsed, give to robustifier
# class Robustifier
#   def initialize(modelpath, invname)
#     @modelpath = modelpath
#     @invname = invname
#   end
# end


