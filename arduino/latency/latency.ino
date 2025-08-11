#define HWSERIAL Serial1

const int buttonPin      = 2;   // Pin where the button is connected
const int micPin         = 23;  // Pin where the microphone sensor is connected
const int threshold      = 30;  // Threshold for detecting audio onset
const int errorThreshold = 5;   // Ignore any delays ≤ this (ms)
const int upperThreshold = 50;

unsigned long buttonPressTime;
unsigned long audioDetectTime;

unsigned long sampleTimeA;
unsigned long sampleTimeB;
unsigned long sampleTime;

// 0 = idle (waiting for press)
// 1 = pressed (waiting for mic to go quiet)
// 2 = pressed & quiet (waiting for audio onset)
// 3 = done (waiting for release)
int state = 0;

void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(115200);
  // HWSERIAL.begin(9600);
}

void loop() {
  // read mic "delta"
  // int mn = 1024, mx = 0;
  // sampleTimeA = micros();
  // for (int i = 0; i < 5; i++) {
  //   int v = analogRead(micPin);
  //   mn = min(mn, v);
  //   mx = max(mx, v);
  // }
  // int delta = mx - mn;
  int delta = analogRead(micPin);
  // sampleTimeB = micros();
  // sampleTime = (sampleTimeB-sampleTimeA);
  // Serial.println(sampleTime);

  bool pressed = (digitalRead(buttonPin) == LOW);
  // Serial.println(delta);

  switch (state) {
    case 0: // idle
      if (pressed) {
        buttonPressTime = millis();
        state = 1;
      }
      break;

    case 1: // just pressed: wait until mic is quiet
      if (delta < threshold) {
        state = 2;
      }
      break;

    case 2: // waiting for sound onset
      if (delta >= threshold) {
        audioDetectTime = millis();
        unsigned long delayTime = audioDetectTime - buttonPressTime;
        if ((delayTime > errorThreshold) && (delayTime < upperThreshold)){
        // if ((delayTime > errorThreshold)){
          Serial.println(delayTime);
          Serial.println();
        delay(100);

          // HWSERIAL.print(delayTime);
        }
        // Move to “done” so we don’t log again until button release
        state = 3;
      }
      break;

    case 3: // logged once: wait for user to lift finger
      if (!pressed) {
        state = 0;
      }
      break;
  }
}
