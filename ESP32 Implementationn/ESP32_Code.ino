// ================= PIN DEFINITIONS =================
#define BTN_ONE     32   
#define BTN_ZERO    25  

#define LED_LOCKED    18
#define LED_UNLOCKED  19
#define LED_ERROR     21

// ================= PASSWORD =================
int password[4] = {1, 0, 1, 1};
int entered[4] = {0,0,0,0};
int indexPos = 0;

int errorCount = 0;
bool systemLocked = false;

void setup() {
  Serial.begin(115200); 

  pinMode(BTN_ONE, INPUT_PULLDOWN);
  pinMode(BTN_ZERO, INPUT_PULLDOWN);

  pinMode(LED_LOCKED, OUTPUT);
  pinMode(LED_UNLOCKED, OUTPUT);
  pinMode(LED_ERROR, OUTPUT);

  digitalWrite(LED_LOCKED, HIGH);
  digitalWrite(LED_UNLOCKED, LOW);
  digitalWrite(LED_ERROR, LOW);

  delay(100); 
}

void loop() {
  if(systemLocked) {
    digitalWrite(LED_LOCKED, HIGH);
    digitalWrite(LED_UNLOCKED, LOW);
    digitalWrite(LED_ERROR, LOW);
    return;
  }

  // BUTTON 1
  if(digitalRead(BTN_ONE) == HIGH) {
    if(indexPos < 4) {
      entered[indexPos++] = 1;
      Serial.print("Added 1 at position ");
      Serial.println(indexPos-1);
      printEntered();
      
      // If 4 digits are reached, check immediately
      if(indexPos == 4) {
        delay(500); 
        checkPassword();
      }
    }
    delay(500); 
  }

  // BUTTON 0
  if(digitalRead(BTN_ZERO) == HIGH) {
    if(indexPos < 4) {
      entered[indexPos++] = 0;
      Serial.print("Added 0 at position ");
      Serial.println(indexPos-1);
      printEntered();

      // If 4 digits are reached, check immediately
      if(indexPos == 4) {
        delay(500);
        checkPassword();
      }
    }
    delay(500);
  }
}

// ================= PASSWORD CHECK =================
void checkPassword() {
  bool correct = true;

  for(int i=0; i<4; i++) {
    if(entered[i] != password[i]) {
      correct = false;
      break;
    }
  }

  if(correct) {
    Serial.println("Password correct!");
    digitalWrite(LED_UNLOCKED, HIGH);
    digitalWrite(LED_LOCKED, LOW);
    digitalWrite(LED_ERROR, LOW);
    errorCount = 0;
  } else {
    Serial.println("Password wrong!");
    errorCount++;
    digitalWrite(LED_ERROR, HIGH);
    delay(500);
    digitalWrite(LED_ERROR, LOW);

    if(errorCount >= 3) {
      systemLocked = true;
      Serial.println("System locked after 3 wrong attempts");
    }
    digitalWrite(LED_LOCKED, HIGH);
    digitalWrite(LED_UNLOCKED, LOW);
  }

  // Reset for next attempt
  for(int i=0; i<4; i++) entered[i]=0;
  indexPos = 0;
}

void printEntered() {
  Serial.print("Current array: ");
  for(int i=0; i<indexPos; i++) {
    Serial.print(entered[i]);
    Serial.print(" ");
  }
  Serial.println();
}