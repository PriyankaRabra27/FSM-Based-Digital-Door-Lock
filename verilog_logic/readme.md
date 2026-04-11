## Verilog Logic

This folder contains the core Verilog implementation of the FSM-based digital door lock. It includes:

- `digital_lock_fsm.v` – main FSM design module
- `test_bench.v` – testbench for simulation
- simulation waveform – verifies the behavior of the design

### Functionality
The system is designed to detect the 4-bit input sequence **1-0-1-1**.

- If the correct sequence is entered, the lock is opened
- `unlocked = 1` and `locked = 0`
- If the sequence is incorrect, the system stays locked

### Verification
The timing diagram confirms the logical correctness of the design through simulation.

### Hardware Relevance
This logic is synthesizable, so it can be mapped to digital hardware such as an FPGA or ASIC.
