# PrintVisitor.
# This prints all the combinations of faults provided.
# Note: executing visitor pattern w/ class bc side effects will be needed.
# Author: William Morris

class PrintVisitor

  # Print a TLA+ formatted set of faults.
  def visit(faults)
    print "Spec ==\n/\\ Next\n"
    faults.each { | fault | puts "/\\ #{fault}" }
    # Note: return value indicates traversal should not end abruptly.
    true
  end

end