# FaultCrosser

FaultCrosser is a tool for calculating the robustness of TLA+ libraries built with fault-centered design!

## Dependencies
- TLA+
- The TLC model checker
- Ruby

## Installation
`git clone https://github.com/Willmo3/FaultCrosser.git`

## Usage
In order to run tlarobust, you must be following the fault-centered design pattern exemplified by RobustNet (https://github.com/Willmo3/RobustNet.git). 

`./tlarobust.rb [composed model] [invariant name] [path to newline-separated list of fault names]`

An example of this can be found in `examples/twophase`
