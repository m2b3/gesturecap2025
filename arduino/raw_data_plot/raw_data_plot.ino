const int microphonePin = 22;

void setup() {
  Serial.begin(115200);
}

void loop() {
  // 1) Grab current time in microseconds
  unsigned long ts = micros();

  // 2) Read microphone
  int reading = analogRead(microphonePin);

  // 3) Print timestamp and reading
  //    Format: "<timestamp_us> <reading>\n"
//   Serial.print(0); // To freeze the lower limit
//   Serial.print(" ");
//   Serial.print(400); // To freeze the upper limit
// Serial.print(" ");
  // Serial.print(ts);
  // Serial.print(' ');
  // Serial.println(reading);
  if (reading>50){
    Serial.println(reading);
  }

  // 4) Small delay to avoid flooding (adjust as needed)
  // delay(10);
}
