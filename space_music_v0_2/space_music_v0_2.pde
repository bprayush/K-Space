import ddf.minim.*;
import ddf.minim.spi.*; // for AudioRecordingStream
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

//Object definitions
Serial serial;
Minim minim;
FilePlayer ambiance;  
FilePlayer b1;
FilePlayer g1;
FilePlayer r1;
FilePlayer r2;
FilePlayer disruptor;
FilePlayer disruptorB;
FilePlayer doubkik;
FilePlayer leaves;
FilePlayer filler;
FilePlayer singingBowl;
AudioOutput out;

//variable definitions
float value;
String raw;
String temp;
char[] acc;

//file name 
String ambianceName = "L - A loop.wav";  
String b1Name = "B1.wav";
String disruptorName = "disruptor.wav";
String disruptorbName = "disruptor b.wav";
String doubkikName = "doubkik.wav";
String g1Name = "G1 short.wav";
String leavesName = "leaves.wav";
String r1Name = "R1.wav";
String r2Name = "R2.wav";
String fillerName = "there's life below.wav";
String bowl="singing bowl.wav";

//Position variables
int r1Pos=0;
int g1Pos=0;
int b1Pos=0;
int r2Pos=0;
int disPos=0;
int disbPos=0;
int singingPos;
  
void setup()
{
  size(640, 240);
  serial = new Serial(this, "/dev/ttyUSB0", 9600);
  minim = new Minim(this);
  out = minim.getLineOut();
  
  //Ambiance player instantiate, loop it!
  ambiance = new FilePlayer(minim.loadFileStream(ambianceName));
  ambiance.loop();
  
  //B1 player instantiate, no loop
  b1 = new FilePlayer(minim.loadFileStream(b1Name));
  b1.patch(out);
  
  //Disruptor instantiate, no loop
  disruptor = new FilePlayer(minim.loadFileStream(disruptorName));
  disruptor.patch(out);
  
  //Disruptor B instantiate, no loop
  disruptorB = new FilePlayer(minim.loadFileStream(disruptorbName));
  disruptorB.patch(out);
  
  //Doubkik instantiatie, no loop
  doubkik = new FilePlayer(minim.loadFileStream(doubkikName));
  doubkik.patch(out);
  
  //G1 instantiate, no loop;
  g1 = new FilePlayer(minim.loadFileStream(g1Name));
  g1.patch(out);
  
  //Leave instantiate, no loop
  leaves = new FilePlayer(minim.loadFileStream(leavesName));
  leaves.patch(out);
  
  //Singing bowl instantiate, no loop
  singingBowl = new FilePlayer(minim.loadFileStream(bowl));
  singingBowl.patch(out);
  
  //R1 instantiate, no loop
  //r1 = new FilePlayer(minim.loadFileStream(r1Name));
  //r1.loop();
  //r1.patch(out);
  
  //R2 instantiate, no loop
  r2 = new FilePlayer (minim.loadFileStream(r2Name));
  r2.patch(out);
 
  ambiance.patch(out);
   
}

void draw()
{
  //get positions
  //r1Pos = r1.position();
  r2Pos = r2.position();
  b1Pos = b1.position();
  g1Pos = g1.position();
  disPos = disruptor.position();
  disbPos = disruptorB.position();
  singingPos = singingBowl.position();
  
  //println("Disruptor Position: "+disPos);
  //println("Disruptor Length: "+disruptor.length());
  
  //get serial data from arduino as string
  raw = serial.readStringUntil('\n');
  //println(serial.available());
  //println(raw);
  
  //Only run if serial is available and data is not NULL
  if(serial.available()>=0 && raw!=null)
  {
    //store initiation character in acc array
    acc = raw.substring(0,1).toCharArray();
    
    //store the corresponding values in temp variable;
    temp = raw.substring(1, raw.length());
    
    //If recieved is ACC's X axis [-3.00, -3.99]
    //Use dis
    if( acc[0] == 'X' )
    {
      
      if(isFloat(temp))
      {
        value = Float.valueOf(temp);
        println("Recieved X: "+value);
        if( (value > -5.00|| value <=-5.99) && !disruptor.isPlaying())
        {
         // println("Recieved Xasdf"+value);
          disruptor.play();
        }
        if( disPos == disruptor.length() && (value > -5.00 || value <= -5.99) )
        {
         // println("testingadfajjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
          disruptor.rewind();
        }
      }
    }
     
    //If recieved is ACC's Y axis [-6.00, -6.99]
    //use disb
    if( acc[0] == 'Y' )
    {
      if(isFloat(temp))
      {
        value = Float.valueOf(temp);
        println("Recieved Y: "+value);
        if( (value > -1.00 || value <= -1.99) && !disruptorB.isPlaying())
        {
          //println("Recieved Yasdfasd"+value);
          disruptorB.play();
        }
        if( disbPos == disruptorB.length() && (value > -1.00 || value <= -1.99) )
        {
          disruptorB.rewind();
        }
      }
    }
    
    //If recieved is luminous sensor
    //user r2
    if( acc[0] == 'L' )
    {
       //println("Recieved L"); 
       if(isFloat(temp))
       {
         value = Float.parseFloat(temp);
         //println(value);
         if( value > 100 && !r2.isPlaying() )
           r2.play();
         if ( r2Pos == r2.length() && value > 100 )
           r2.rewind();
       }
    }
    
    //If recieved is Red value
    //use g1
    if( acc[0] == 'R' )
    {
      //println("Recieved R");
      if(isFloat(temp))
      {
        value = Float.parseFloat(temp);
        if (value > 20 && !g1.isPlaying())
          g1.play();
        if ( g1Pos == g1.length() && value > 20 )
          g1.rewind();
      }
    }
    
    //If recieved is Blue value
    //use b1
    if( acc[0] == 'B' )
    {
      //println("Recieved B");
      value = Float.parseFloat(temp);
      if( value > 20 && !b1.isPlaying() )
        singingBowl.play();
      if( singingPos == singingBowl.length() && value > 20 )
        singingBowl.rewind();
    }
    
    
  }

}

/*
void keyPressed()
{
  if(key == '1')
  {
    r1.patch(out);
  }
  if(key == '2')
    r1.play();
    /*
  if(key == '2')
    osc.setFrequency(0.1);
  if(key == '3')
    osc.setFrequency(8);
  if(key == '4')
    osc.setFrequency(11);
  if (key == '5')
    osc.setWaveform(Waves.SQUARE);
  if (key == 'a')
    osc.setWaveform(Waves.SINE);
  
}
*/