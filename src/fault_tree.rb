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
    # Traverse procedure:
    # Traverse lattice in breadth-first order.

    sub_faults = Queue.new
    sub_faults.enq faults
    
    until sub_faults.empty?
      fault = sub_faults.deq

      # If this fault is valid, enqueue every subcombination of faults to be visited.
      if visitor.visit(fault)
        for i in 0...fault.length
          sub_faults.enq(fault[0...i].concat fault[i + 1..-1])
        end
      end
    end
  end
end
