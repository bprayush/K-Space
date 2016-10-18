/* =============================================================================
 * all_sensors.ino
 *
 * Outputs all sensor readings in a JSON format that can be read by the Ardusat
 * Experiment Platform (http://experiments.ardusat.com).
 * =============================================================================
 */


/*-----------------------------------------------------------------------------
 *  Includes
 *----------------------------------------------------------------------------*/
#include <Arduino.h>
#include <Wire.h>
#include <ArdusatSDK.h>


/*-----------------------------------------------------------------------------
 *  Setup Software Serial to allow for communication
 *----------------------------------------------------------------------------*/
ArdusatSerial serialConnection(SERIAL_MODE_HARDWARE_AND_SOFTWARE, 8, 9);


/*-----------------------------------------------------------------------------
 *  Constant Definitions
 *----------------------------------------------------------------------------*/
Acceleration accel;
TemperatureTMP ambient;
Gyro gyro;
TemperatureMLX infrared;
Luminosity lum;
Magnetic mag;
Pressure pre;
RGBLightTCS rgbTcs;
RGBLightISL rgbIsl;
UVLightML uvMl;
UVLightSI uvSi;


/* 
 * ===  FUNCTION  ==============================================================
 *         Name:  setup
 *  Description:  This function runs when the Arduino first turns on/resets.
 *                This is our chance to take care of all one-time configuration
 *                tasks to get the program ready to begin logging data.
 * =============================================================================
 */
void setup(void)
{
  serialConnection.begin(9600);

  /* We're ready to go! */
  serialConnection.println("");

  accel.begin();
  ambient.begin();
  gyro.begin();
  infrared.begin();
  lum.begin();
  mag.begin();
  pre.begin();
  rgbTcs.begin();
  rgbIsl.begin();
  uvMl.begin();
  uvSi.begin();
}

String variable;
int accX, accY, accZ;
/* 
 * ===  FUNCTION  ==============================================================
 *         Name:  loop
 *  Description:  After setup runs, this loop function runs until the Arduino 
 *                loses power or resets.
 * =============================================================================
 */
void loop(void)
{
  char accValues[3][10];
  // Read Accelerometer
  variable = accel.readToCSV("AC");
 // Serial.println(variable);
  getAcc(variable, accValues);
  accX = atoi(accValues[0]);
  accY = atoi(accValues[1]);
  accZ = atoi(accValues[2]);
  Serial.print("Accx: ");
  Serial.println(accX);
  Serial.print("Accy: ");
  Serial.println(accZ);
  Serial.print("Accz: ");
  Serial.println(accZ);

  if(accX < 0)
    serialConnection.println(valueToJSON("cowbell1", DATA_UNIT_NONE, 1));
  if(accY > 0)
    serialConnection.println(valueToJSON("cowbell2", DATA_UNIT_NONE, 1));
  if(accZ > -5)
    serialConnection.println(valueToJSON("sitar1", DATA_UNIT_NONE, 1));

  // Read Temp from TMP102
  //serialConnection.println(ambient.readToJSON("ambientTemp"));

  // Read Gyro
 // Serial.println(gyro.readToCSV("gyro"));

  // Read MLX Infrared temp
  //serialConnection.println(infrared.readToJSON("infraredTemp"));

  // Read TSL2561 Luminosity
  //serialConnection.println(lum.readToJSON("luminosity"));

  // Read Magnetometer
  //serialConnection.println(mag.readToJSON("magnetic"));

  // Read Barometric Pressure
  //serialConnection.println(pre.readToJSON("pressure"));

  // Read TCS34725 RGB (Default)
  //serialConnection.println(rgbTcs.readToJSON("rgbTcs"));

  // Read ISL29125 RGB
  //serialConnection.println(rgbIsl.readToJSON("rgbIsl"));

  // Read ML8511 UV (Default)
  //serialConnection.println(uvMl.readToJSON("uvMl"));

  // Read SI1132 UV
  //serialConnection.println(uvSi.readToJSON("uvSi"));
  
  //Serial.println(valueToJSON("duck1", DATA_UNIT_NONE, 1));
  //delay(50);
  //Serial.println(valueToJSON("snare", DATA_UNIT_NONE, 1));




  delay(150);
} 


int getAcc(String x, char value[][10]){
  
    int index= 0, i=0, j=0;
   
   

    while( x[index] != 'C' )
    {
      x[index++];
    }
    index++;
    index++;
    while( x[index] != ',' )
    {
      value[i][j++] = x[index++];
      //Serial.print("inside acc: ");
    //Serial.println(value[i++]);
      
    }
    value[i++][j]='\0';
    j=0;
    index++;
    while( x[index] != ',' )
    {
      value[i][j++] = x[index++];
      //Serial.print("inside acc: ");
    //Serial.println(value[i++]);
      
    }
    value[i++][j]='\0';
     j=0;
     index++;
    while( x[index] != ',' )
    {
      value[i][j++] = x[index++];
      //Serial.print("inside acc: ");
    //Serial.println(value[i++]);
      
    }
    value[i++][j]='\0';


  
}
