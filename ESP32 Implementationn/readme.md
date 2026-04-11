## ESP32 Physical Prototype

This folder contains the embedded code for the physical prototype of the digital door lock implemented on ESP32.

The system uses two push buttons to enter binary inputs (`1` and `0`). The entered 4-bit sequence is stored in an array and checked against the predefined password **1-0-1-1**.

### Pin Mapping
- **BTN_ONE** → GPIO 32
- **BTN_ZERO** → GPIO 25
- **LED_LOCKED** → GPIO 18
- **LED_UNLOCKED** → GPIO 19
- **LED_ERROR** → GPIO 21

### Code Structure
- `delay(500)` is used for basic button debouncing
- entered bits are stored in `entered[4]`
- a `for` loop compares the entered sequence with the password
- incorrect attempts increase an error counter
- after 3 wrong attempts, the system becomes permanently locked

### Output Indication
- **Locked LED** indicates locked state
- **Unlocked LED** indicates successful password entry
- **Error LED** indicates an incorrect password

This prototype demonstrates the practical hardware implementation of the digital door lock on ESP32.
