/*

  All codes are a part of karkhana's space program called the "K Space"
  The following program for arduino is required for running the other programs to run

*/
#include <ArdusatSDK.h>


ArdusatSerial serialConnection(SERIAL_MODE_HARDWARE_AND_SOFTWARE, 8, 9);

Acceleration acc;
RGBLightTCS Argb;//65535
Luminosity lum;
float value;

void setup()
{
  acc.begin();
  Argb.begin();
  lum.begin();
  serialConnection.begin(9600);
  Serial.begin(9600);
 // pinMode(12, OUTPUT);
}


void loop()
{

 
 // digitalWrite(12, HIGH);
  Argb.read();
  serialConnection.print("R");
  value = Argb.red;
 // value = map(value, 0, 8000, 0, 255);
  serialConnection.println(value);

  serialConnection.print("G");
  value = Argb.green;
  //value = map(value, 0, 8000, 0, 255);
  serialConnection.println(value);

  serialConnection.print("B");
  value = Argb.blue;
  //value = map(value, 0, 8000, 0, 255);
  serialConnection.println(value);

  //Accelerations
  acc.read();
  serialConnection.print("X");
  serialConnection.println(acc.x);
  serialConnection.print("Y");
  serialConnection.println(acc.y);

  //Luminosity
  lum.read();
  serialConnection.print("L");
  serialConnection.println(lum.lux);

  
  
  delay(25);
 
}
