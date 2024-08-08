# frozen_string_literal: true

# RobustVisitor.
# Traverse a lattice of faults, finding the maximal combinations of faults that are operational.

# As soon as a combination of faults is validated, add it to the set of faults that are valid.
# And stop descending.

# Author: William Morris

class RobustVisitor
  # The RobustVisitor takes a path to a TLA+ model.
  # This model will be modified by the visitor.

  # Assumption: the modelpath contains no spec.
  def initialize(modelpath)
    @path = modelpath
    @robustness = {}
  end

  # ***** IO OPERATIONS ***** #

  def open
    @file = File.open(@path, "rw")
  end

  def close
    @file.close
  end

  # ***** LATTICE TRAVERSAL ***** #

  # Visit: currently, we assume that the traversal process will be serialized.
  # If not, we'll probably want to find a better language for parallelization
  # Bc we're going to need shared state to track the robust sets.
  def visit(faults)
    # Add to specification a single line with the set of faults.
    true
  end
end
