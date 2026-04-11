# FSM-Based Digital Door Lock

A digital door lock project based on **Finite State Machine (FSM)** logic, implemented in two forms:

- **Verilog model** for digital design, simulation, and verification
- **ESP32-based hardware prototype** for practical implementation

The system checks a **4-bit password sequence: `1-0-1-1`**.  
If the entered sequence is correct, the lock opens. If the sequence is incorrect, the system remains locked. After **3 wrong attempts**, the system enters a **hard-lock condition**.

---

## Project Overview

This project was built to understand how a real-world digital locking system can be designed using FSM concepts and then demonstrated on hardware.

The project has two major parts:

### 1. Verilog FSM Design
The lock behavior is modeled using Verilog, where each state represents progress in matching the password sequence. The Verilog design is verified through a testbench and simulation waveform.

### 2. ESP32 Hardware Prototype
The same password-checking idea is implemented on an ESP32 using:
- two push buttons for binary input (`1` and `0`)
- LEDs to indicate **locked**, **unlocked**, and **error** states

---

## Features

- 4-bit binary password-based digital lock
- Password sequence: **1011**
- FSM-based sequential verification
- Locked and unlocked status indication
- Error indication for incorrect password
- Hard lock after **3 wrong attempts**
- Verilog simulation with waveform verification
- Practical prototype using ESP32

---

## FSM Working Principle

The FSM checks the input sequence one bit at a time.

- Initial state: **Idle**
- Correct input sequence: **1 → 0 → 1 → 1**
- If all bits are correct, the system goes to the **unlock state**
- If a wrong input is entered, the system goes to the **error state**
- After 3 incorrect attempts, the system enters a **lock state**

This makes FSM a natural choice because password verification is a **sequential process**, where each next step depends on previous correct inputs.
   
#Demo link
[Project Demo](https://drive.google.com/file/d/1xnA1jS1-hp0pL9wrcC-nkUvl4oBBP6dQ/view?usp=drivesdk)
[Project Demo](https://drive.google.com/file/d/15U0jUlOeIUN3lceCGRsfHp0Vr16zrGMH/view?usp=drivesdk)





