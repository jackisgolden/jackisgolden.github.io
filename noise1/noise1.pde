float x;
float y;
float t;
float h;
public void setup(){
  size(150,100);
  background(0);
  colorMode(HSB, 360, 100, 100);
  x = random(100);
  y = random(100);
  t = 0;
  h = 0;
  
}

public void draw(){
  background(0);
  //x += .1;
  //y += .1;
  t += .05;
  h += .1;
  for(float i = 0; i < height; i++)
    for(float j = 0; j < width; j++)
     {
       float hue = (map(noise(j / 20 + x, i / 20 + y, t), 0, 1, 0, 360) + h) % 360;
       stroke(hue, 80, 90);
       point(j, i);
     }
}