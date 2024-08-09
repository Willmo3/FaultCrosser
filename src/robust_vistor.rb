require_relative "fault_model"
require "fileutils"

# RobustVisitor.
# Traverse a lattice of faults, finding the maximal combinations of faults that are operational.

# As soon as a combination of faults is validated, add it to the set of faults that are valid.
# And stop descending.

# Author: William Morris

class RobustVisitor
  attr_reader :robustness

  # The RobustVisitor takes a path to a TLA+ model.
  # This model will be modified by the visitor.
  def initialize(model, config_path)
    @model = model
    @config_path = config_path

    @model = FaultModel.new @model_path
    @robustness = Set.new
  end

  # ***** LATTICE TRAVERSAL ***** #

  # Visit: currently, we assume that the traversal process will be serialized.
  def visit(faults)
    faults = Set.new(faults)

    # Make sure that these faults aren't a subset of an existing fault
    if @robustness.any? {| set | faults.subset? set }
      return false
    end

    # Prime file to check against this set of faults.
    @model.fault_spec(faults)

    # Flush the TLC states directory.
    # Otherwise, it may whine abt files already existing
    # If we move too fast.
    if Dir.exist? "states"
      FileUtils.rm_rf("states")
    end

    # Suppress TLC output and model check
    stdout = $stdout.clone
    $stdout.reopen("/dev/null")
    mc = system "tlc", @model_path, "-config", @config_path
    $stdout.reopen(stdout)

    if mc
      # If we're robust against this combination of faults, add it as a maximal robust envelope.
      # Do not traverse further.
      @robustness << faults
      false
    else
      # Otherwise, descend to subsets.
      true
    end
  end
end
