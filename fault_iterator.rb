# frozen_string_literal: true

# FaultIterator.
# Given a file containing newline-separated faults
# Create combination of those faults in the TLA+ context.
# Author: Will Morris

class FaultIterator
  # Initializing class = read in faults
  def initialize(file)
    @faults = File.foreach(file).reduce(Set()) { |set, line| set.add(line)}
  end
end
