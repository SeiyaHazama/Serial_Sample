import processing.serial.*;

Serial serial;
PFont font;
boolean isRecord = false, isConnect;
PrintWriter csv;
String cnto = "/dev/tty.usbmodem1411";
String text, input, filename, data;

void setup() {
  printArray(Serial.list());
  size(600, 300);
  font = loadFont("CourierNewPSMT-48.vlw");
  textFont(font, 20);
  background(120);
  isConnect = conSerial();
  frameRate(30);
}

void draw() {
  background(120);
  if (isConnect) {
    text("Connect: " + cnto, 20, 20);
    input = trim(serial.readStringUntil('\n'));
    if (input != null) {
      data = input;
      text = "Receive: " + data;
      println(text);
    }
    if (isRecord) {
      csv.println(data);
      text("Recording...", 20, 100);
    } else {
      text("If you want to record,\nprease press any key.", 20, 100);
    }
    try {
      text(text, 20, 50);
    }
    catch(NullPointerException e) {
    }
  } else {
    text("Connect: " + cnto + " is can not use.\nPrease restart this program.", 20, 20);
  }
}

boolean conSerial() {
  try {
    serial = new Serial(this, cnto, 57600);
    serial.clear();
    return true;
  } 
  catch (Exception e) {
    return false;
  }
}

void keyPressed() {
  if (isConnect) {
    if (!isRecord) {
      csv = createWriter(setFilename());
      isRecord = true;
    } else {
      csv.flush();
      csv.close();
      isRecord = false;
    }
  }
}

String setFilename() {
  filename = "MicomRec_";
  filename += year();
  if (month() < 10) filename += "0";
  filename += month();
  if (day() < 10) filename += "0";
  filename += day();
  if (hour() < 10) filename += "0";
  filename += hour();
  if (minute() < 10) filename += "0";
  filename += minute();
  if (second() < 10) filename += "0";
  filename += second();
  filename += ".csv";
  return filename;
}
