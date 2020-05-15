// Part of this code was taken from daniel shiffmanDaniel Shiffman
Star[] stars = new Star[200];

// I create a variable "speed", it'll be useful to control the speed of stars.
float speed;

void setup() {
  size(600, 600);
  // I fill the array with a for loop;
  // running 800 times, it creates a new star using the Star() class.
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  // i link the value of the speed variable to the mouse position.
  speed = map(mouseX, 0, width, 0, 15);

  background(0);
  // I shift the entire composition,
  // moving its center from the top left corner to the center of the canvas.
  translate(width/2, height/2);
  // I draw each star, running the "update" method to update its position and
  // the "show" method to show it on the canvas.
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}
private class Star{
    float x, y, z, pz;
  
    Star() {
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      z = random(width/2);
      pz = z;
    }
  
    void update() {
      z = z - speed;
      if (z < 1) {
        z = width/2;
        x = random(-width/2, width/2);
        y = random(-height/2, height/2);
        pz = z;
      }
    }
  
    void show() {
      fill(255);
      noStroke();
      float sx = map(x / z, 0, 1, 0, width/2);
      float sy = map(y / z, 0, 1, 0, height/2);
      
      float r = map(z, 0, width/2, 16, 0);
      //ellipse(sx, sy, r, r);
      for(int i = 0; i < 12; i++)
        ellipse(10 * r * sin(2*PI*i/12) + sx, 10 * r  * -cos(2*PI*i/12) + sy, r, r);
  
      float px = map(x / pz, 0, 1, 0, width/2);
      float py = map(y / pz, 0, 1, 0, height/2);
  
      pz = z;
  
      stroke(255);
      for(int i = 0; i < 12; i++)
        line(10 * r * sin(2*PI*i/12) + px, 10 * r  * -cos(2*PI*i/12) + py, 10 * r * sin(2*PI*i/12) + sx, 10 * r  * -cos(2*PI*i/12) + sy);
    }
  }