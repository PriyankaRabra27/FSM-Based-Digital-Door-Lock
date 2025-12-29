This folder contains circuit configuration and code structure of the physical prototype.

Code Structure:
-Debouncing Logic: Each input includes a delay(500) to ensure mechanical vibration of the button doesn't register as multiple presses.
-Input Array: Entered digits are stored in a 4-element integer array entered[4].
-Verification: A for loop compares the entered array against a hardcoded password array.



