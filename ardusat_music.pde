import ddf.minim.*;

Minim minim;
AudioPlayer[] groove;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  groove[0] = minim.loadFile("1.mp3", 2048);
  groove[1] = minim.loadFile("2.mp3", 2048);
}

void draw()
{
  background(0);
  stroke(255);
  
  for(int i =)
}