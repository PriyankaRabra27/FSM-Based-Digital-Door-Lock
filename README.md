# FSM-Based-Digital-Door-Lock
An embedded PIN-based door lock system designed using a finite state machine.
The fsm logic is modelled in Verilog HDL to demonstrate level implementation.

#Project Overview
This project implements a secure door lock mechanism where access is granted on;y when correct PIN is entered.
The physical system is implemented using ESP32, while a verilog based FSM model is a conceptual hardware implementation.

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



