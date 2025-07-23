const int micPin = 22;

void setup() {
  Serial.begin(115200);
}

void loop() {
  // 1) Grab current time in microseconds
  int mn = 1024, mx = 0;
  for (int i = 0; i < 5; i++) {
    int v = analogRead(micPin);
    mn = min(mn, v);
    mx = max(mx, v);
  }
  int delta = mx - mn;

  Serial.println(delta);

  // 4) Small delay to avoid flooding (adjust as needed)
  // delay(50);
}
