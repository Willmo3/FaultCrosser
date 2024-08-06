# frozen_string_literal: true

# RobustVisitor.
# Traverse a lattice of faults, finding the maximal combinations of faults that are operational.

# As soon as a combination of faults is validated, add it to the set of faults that are valid.
# And stop descending.

# Author: William Morris

class RobustVistor
  # Visit: currently, we assume that the traversal process will be serialized.
  # If not, we'll probably want to find a better language for parallelization
  # Bc we're going to need shared state to track the robust sets.
  def visit
    true
  end
end
