# FSM-Based-Digital-Door-Lock
An embedded PIN-based door lock system designed using a finite state machine.
The fsm logic is modelled in Verilog HDL and prototyped low-cost embedded solutions on ESP32.

#Project Overview
This project implements a secure door lock mechanism where access is granted on;y when correct PIN is entered.
The physical system is implemented using ESP32, while a verilog based FSM model is a conceptual hardware implementation.

#Features:
-Binary Input: Uses 2 tactile buttons to represent binary 0 and 1.
-LED feedback: Red(GPIO 18) System is locked
               Green(GPIO 19) System is unlocked
               Yellow(GPIO21) Error
-3 strike lockout: After 3 incorrect attempts, the system enters a hard-lock state for security.

#FSM Design
The system operates using the following states:

- IDLE – Waiting for user interaction  
- INPUT – User enters the PIN   
- UNLOCK – Correct PIN, access granted  
- ERROR – Incorrect PIN, error indication

  Firmware Implementation:  
  - Microcontroller-based (ESP32)  
  - Written in C/C++  
  - Handles button input, PIN verification, and output control  

  Hardware Modeling:  
  - FSM logic described using Verilog HDL  
  - Represents how the same control logic can be implemented on FPGA  
  - Included for learning and design demonstration purposes   



