# frozen_string_literal: true

# FaultTree.
# Given a file containing newline-separated faults
# Allow traversing those faults.
# Author: Will Morris

class FaultTree
  # Initializing class = read in faults
  def initialize(file)
    @faults = File.foreach(file).reduce(Array.new) { |arr, line| arr.append(line.strip)}
  end

  # Traverse the set of faults.
  # Visitor: Fault-tree visitor. Must follow visitor API
  # I.e. visit returns true -> continue iterating.
  def traverse(visitor, faults=@faults)
    # Does the visitor wish to continue iterating?
    if visitor.visit(faults)
      # If so, visit every combination of faults after this.
      for i in 0...faults.length
        new_combo = faults[0...i].concat faults[i+1..-1]
        traverse(visitor, new_combo)
      end
    end
  end

  # To iterate over a set of faults, iterate over the lattice.
end
