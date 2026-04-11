## ESP32 Physical Prototype

This folder contains the circuit configuration and embedded code for the physical prototype of the digital door lock system.

### Functionality
The prototype uses two push buttons as binary inputs:
- one button enters `1`
- one button enters `0`

The system stores a 4-bit input sequence and compares it with the predefined password **1-0-1-1**.

### Code Structure
- **Input Handling:** Button presses are read through GPIO pins connected to the ESP32.
- **Debouncing Logic:** A `delay(500)` is used after each button press to prevent multiple registrations due to mechanical bouncing.
- **Input Storage:** Entered bits are stored in a 4-element integer array `entered[4]`.
- **Password Verification:** Once 4 bits are entered, a `for` loop compares the entered sequence with the hardcoded password array.
- **Error Handling:** Incorrect entries increase the error counter.
- **Security Feature:** After 3 wrong attempts, the system enters a permanently locked state.

### Output Indication
The system uses LEDs to indicate its status:
- **Locked LED** → system is locked
- **Unlocked LED** → correct password entered
- **Error LED** → wrong password entered

### Note
This implementation was developed as a simple working hardware prototype. It successfully demonstrates password entry, verification, error indication, and lockout behavior on ESP32.


