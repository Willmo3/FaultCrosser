# frozen_string_literal: true

# FaultTree.
# Given a file containing newline-separated faults
# Allow traversing those faults.
# Author: Will Morris

class FaultTree
  # Initializing class = read in faults
  def initialize(file)
    @faults = File.foreach(file).reduce(Set.new) { |set, line| set.add(line)}
  end

  # To iterate over a set of faults, iterate over the lattice.
end
