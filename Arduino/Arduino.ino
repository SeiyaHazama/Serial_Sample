int val;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(0);
  Serial.println("Hello World.");
  delay(40);
}
