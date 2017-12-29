import processing.serial.*;

Serial serial;
PFont font;
boolean isConnect = false;
String cnto = "/dev/tty.usbmodem1411";
String data, text;

void setup() {
  printArray(Serial.list());
  size(600, 300);
  font = loadFont("CourierNewPSMT-48.vlw");
  textFont(font, 20);
  background(120);
  isConnect = conSerial();
  frameRate(10);
}

void draw() {
  background(120);
  if (isConnect) {
    text("Connect: " + cnto, 20, 20);
    data = serial.readString();
    text = "Analog0: " + data;
    text(text, 20, 50);
    //println(data);
  } else {
    text("Connect: " + cnto + " is can not use.", 20, 20);
  }
}

boolean conSerial() {
  try {
    serial = new Serial(this, cnto, 9600);
    return true;
  } 
  catch (Exception e) {
    return false;
  }
}