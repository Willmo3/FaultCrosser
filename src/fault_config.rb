# frozen_string_literal: true

# FaultConfig is a TLA+-configuration for a set of invariants.
# Author: Will Morris
class FaultConfig
  attr_reader :path

  # invs_path: Path to newline-separated list of invariants.
  # output_path: path to tla+ cfg file outputted.
  def initialize(invs_path, output_path)
    @path = output_path

    # Read in invariants
    invs = File.readlines invs_path
    unless invs.length > 0
      puts "Error: no invariants specified in #{invs_path}"
      exit 1
    end

    # Write config
    File.open(@path, "w") do | f |
      f.write "SPECIFICATION FaultSpec\nINVARIANTS\n"
      invs.each { | item | f.write "\t#{item}\n" }
    end
  end
end
