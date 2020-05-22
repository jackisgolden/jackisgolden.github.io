int[] notes;
Sequence sequence;
int pointer, increment;

void setup(){
  size(600,600);
  background(0);
  noStroke();
  
  frameRate(10);
  increment = 7;
  pointer = 0;
  notes = {0, 1, 2, 3, 4, 5,  6, 7, 8,  9, 10, 11};

   textSize(32);
}

void draw(){ 
  for(int note : notes) //draw each note
    ellipse(200 * sin(2*PI*note/12) + width/2, 200 * -cos(2*PI*note/12) + height/2, 20, 20);
  stroke(255);
  line(200 * sin(2*PI*pointer/12) + width/2, 200 * -cos(2*PI*pointer/12) + height/2, 200 * sin(2*PI*(pointer + increment) /12) + width/2, 200 * -cos(2*PI*(pointer + increment) /12) + height/2);
  
  if((pointer + increment) % 12 == 0)
  {
    pointer++;
  }
  increment++;
  //pointer += increment;
}