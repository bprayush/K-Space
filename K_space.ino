#include <ArdusatSDK.h>

ArdusatSerial serialConnection(SERIAL_MODE_HARDWARE_AND_SOFTWARE, 8, 9);

Acceleration acc; RGBLightTCS Argb;//65535 Luminosity lum; float value;

void setup() { 
  acc.begin(); 
  Argb.begin(); 
  lum.begin(); 
  serialConnection.begin(9600); 
}

void loop() {

  // READ RGB VALUES FROM THE SENSOR AND SERIAL PRINT IT
  Argb.read(); 
  serialConnection.print("R"); 
  value = Argb.red;  
  serialConnection.println(value);
  
  serialConnection.print("G"); 
  value = Argb.green; 
  serialConnection.println(value);
  
  serialConnection.print("B"); 
  value = Argb.blue; 
  serialConnection.println(value);
  
  //READ ACCELERATION FROM THE SENSOR AND SERIAL PRINT IT
  acc.read(); 
  serialConnection.print("X"); 
  serialConnection.println(acc.x); 
  serialConnection.print("Y"); 
  serialConnection.println(acc.y);
  
  //READ LUMINOSITY FROM THE SENSOR AND SERIAL PRINT IT
  lum.read(); 
  serialConnection.print("L"); 
  serialConnection.println(lum.lux);
  
  delay(25);

}
