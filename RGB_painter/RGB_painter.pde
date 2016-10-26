import processing.serial.*;

Serial serial;
String port = "/dev/ttyACM0";
float val;
String val2;
char[] test;
String temp;
int i =0;
float red, green, blue;

void setup()
{
  serial = new Serial(this, port, 9600);
  size(250, 250);
}

void draw()
{
  
   val2 = serial.readStringUntil('\n');
   //println(val2);
  if(serial.available() > 0 && serial.readStringUntil('\n')!=null)
  {
   test = val2.substring(0,1).toCharArray();
   //println(test[0]);
   temp = val2.substring(1,val2.length());
   
   if ( test[0] == 'R' )
   {
     if(isFloat(temp))   
     {
       red = Float.valueOf(temp);
       //println("asdfasdf");
     }
   }
   if ( test[0] == 'G' )
   {
     if(isFloat(temp))     
       green = Float.valueOf(temp);
   }
   if (test[0] == 'B')
   {
     if(isFloat(temp))     
       blue = Float.valueOf(temp);
   }
   i++;

   background(red, green, blue);
   i=0;
  
  }
}
