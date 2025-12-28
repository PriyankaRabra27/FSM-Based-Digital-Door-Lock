This folder contains circuit configuration and code structure of the physical prototype.

Features:
-Binary Input: Uses 2 tactile buttons to represent binary 0 and 1.
-LED feedback: Red(GPIO 18) System is locked
               Green(GPIO 19) System is unlocked
               Yellow(GPIO21) Error
-3 strike lockout: After 3 incorrect attempts, the system enters a hard-lock state for security.

Hardware Requirements:
-ESP32 Dev Module
-2 tactile push buttons to represent binary 0 and 1
-LEDs(to verify the output) 
-Jumper wires amd breadboard
-10kohm(for pull down configuration) and 220 ohm resistors(for LED current limiting)

Code Structure:
-Debouncing Logic: Each input includes a delay(500) to ensure mechanical vibration of the button doesn't register as multiple presses.
-Input Array: Entered digits are stored in a 4-element integer array entered[4].
-Verification: A for loop compares the entered array against a hardcoded password array.



