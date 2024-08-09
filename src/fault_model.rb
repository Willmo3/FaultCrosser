# A FaultModel is a tla+ model that can easily be extended with added faults.
# Author: Will Morris

class FaultModel

  # To initialize a fault model, pass it a path.
  def initialize(path)
    @path = path

    lines = File.readlines(@path)
    unless lines and lines.length > 1
      puts "Error: invalid TLA+ model at #{path}, does it exist?"
      exit 1
    end

    # Clear the last line. This should be a ====, indicating module ending.
    # Assuming there is some FaultNext.
    lines = lines[0...-1]

    # These defaults will be overwritten.
    lines << "FaultNext == Next\n"
    lines << "FaultSpec == Init /\\ [][FaultNext]_vars\n"
    lines << "===="

    unless File.write(@path, lines.join)
      puts "Error: unable to write modified model"
      exit 1
    end
  end

  # Switch the model to have a fault-spec with the following faults.
  def fault_spec(faults)
    lines = File.readlines(@path)

    unless lines and lines.length > 1
      puts "Error: invalid TLA+ model at #{@path}, does it exist?"
      exit 1
    end

    # Create FaultNext
    fault_next = "FaultNext == Next"
    faults.each do | fault |
      fault_next << " \\/ " << fault.strip
    end

    lines = lines[0...-3]
    lines << fault_next << "\n"
    lines << "FaultSpec == Init /\\ [][FaultNext]_vars\n"
    lines << "===="

    unless File.write(@path, lines.join)
      puts "Error: unable to write modified model"
      exit 1
    end
  end
end
