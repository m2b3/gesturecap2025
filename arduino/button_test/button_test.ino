const int buttonPin = 2;  // Pin where the button is connected
bool lastButtonState = HIGH; // Assume pull-up resistor

void setup() {
  pinMode(buttonPin, INPUT_PULLUP); // Use internal pull-up resistor
  Serial.begin(9600);
}

void loop() {
  bool currentButtonState = digitalRead(buttonPin);

  // Detect state change
  if (currentButtonState != lastButtonState) {
    delay(10); // Basic debounce delay
    currentButtonState = digitalRead(buttonPin); // Read again after debounce
    if (currentButtonState != lastButtonState) {
      if (currentButtonState == LOW) {
        Serial.println("Button pressed");
      } else {
        Serial.println("Button released");
      }
      lastButtonState = currentButtonState;
    }
  }
}
