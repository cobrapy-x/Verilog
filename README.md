# Verilog gate examples

This folder contains simple combinational-logic modules and self-checking
testbenches for Icarus Verilog on macOS.

## Prerequisites

Install Icarus Verilog with Homebrew if it is not already installed:

```sh
brew install icarus-verilog
```

Run the following commands from this folder.

## Compile and run

### AND gate

```sh
iverilog -g2005 -Wall -s and_gate_tb -o and_gate_sim and_gate.v and_gate_tb.v
vvp and_gate_sim
```

This generates `and_gate.vcd`.

### All gates

```sh
iverilog -g2005 -Wall -s all_gates_tb -o all_gates_sim all_gates.v all_gates_tb.v
vvp all_gates_sim
```

This generates `all_gates.vcd`.

### Half adder

```sh
iverilog -g2005 -Wall -s half_adder_tb -o half_adder_sim half_adder.v half_adder_tb.v
vvp half_adder_sim
```

This generates `half_adder.vcd`.

### Existing full adder testbench

```sh
iverilog -g2005 -Wall -s full_adder_tb -o full_sim full_adder.v full_adder_tb.v
vvp full_sim
```

This generates `full_adder.vcd`.

Each self-checking testbench prints a `PASS` or `FAIL` line for every input
combination followed by a summary. Open the corresponding `.vcd` file in
Surfer to inspect the waveform.
# Verilog
