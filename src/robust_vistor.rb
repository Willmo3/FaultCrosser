# frozen_string_literal: true
require_relative "fault_model"

# RobustVisitor.
# Traverse a lattice of faults, finding the maximal combinations of faults that are operational.

# As soon as a combination of faults is validated, add it to the set of faults that are valid.
# And stop descending.

# Author: William Morris

class RobustVisitor
  attr_reader :robustness

  # The RobustVisitor takes a path to a TLA+ model.
  # This model will be modified by the visitor.
  def initialize(model_path, config_path)
    @model_path = model_path
    @config_path = config_path

    @model = FaultModel.new @model_path
    @robustness = Set.new
  end

  # ***** LATTICE TRAVERSAL ***** #

  # Visit: currently, we assume that the traversal process will be serialized.
  def visit(faults)
    # Make sure we're checking against this set of faults!
    @model.fault_spec(faults)

    # Model check
    if system "tlc", @model_path, "-config", @config_path
      # If we're robust against this combination of faults, add it as a maximal robust envelope.
      # Do not traverse further.
      @robustness << faults
      true
    else
      # Otherwise, descend to subsets.
      false
    end
  end
end
