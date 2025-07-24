#define HWSERIAL Serial1

const int buttonPin      = 2;   // Pin where the button is connected
const int micPin         = 22;  // Pin where the microphone sensor is connected
const int threshold      = 50;  // Threshold for detecting audio onset
const int errorThreshold = 5;   // Ignore any delays ≤ this (ms)

unsigned long time1;  // Button press time
unsigned long time2;  // Audio detection time

// State definitions:
// 0 = waiting for button press
// 1 = button was pressed, waiting for audio detection
int state = 0;
bool lastButtonState = HIGH;  // Track previous button state to detect press events

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(115200);
  // HWSERIAL.begin(9600);
}

void loop() {
  // Read microphone signal
  int delta = analogRead(micPin);
  bool currentButtonState = digitalRead(buttonPin);
  bool buttonJustPressed = (lastButtonState == HIGH && currentButtonState == LOW);
  
  switch (state) {
    case 0: // waiting for button press
      if (buttonJustPressed) {
        time1 = millis();  // Record button press time
        state = 1;         // Move to waiting for audio
        Serial.print("Button pressed at: ");
        Serial.println(time1);
      }
      break;

    case 1: // button was pressed, waiting for audio detection
      if (delta >= threshold) {
        time2 = millis();  // Record audio detection time
        unsigned long delayTime = time2 - time1;
        
        if (delayTime > errorThreshold) {
          Serial.print("Audio detected at: ");
          Serial.println(time2);
          Serial.print("Delay: ");
          Serial.print(delayTime);
          Serial.println(" ms");
          Serial.println();
          // HWSERIAL.print(delayTime);
        }
        
        state = 0;  // Reset to wait for next button press
      }
      break;
  }
  
  lastButtonState = currentButtonState;  // Update button state for next iteration
}