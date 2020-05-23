int[] notes;
int pointerb, pointere,  incrementb, incremente, countb, counte;
booleean paused;

public void setup(){
  size(1200,600);
  background(255);
  
  frameRate(10);
  incrementb = 1; incremente = 1; pointerb = 0; pointere = 0; countb = 0; counte = 0;
  notes = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
  paused = false;

  fill(68, 98, 74);
}

public void draw(){ 
   if(!paused){
     bruteForceDraw();
     eficientDraw();
   }
}
public void bruteForceDraw()
{
  stroke(68, 98, 74);
  translate(-width/4, 0);
    for(int note : notes) //draw each note
      ellipse(200 * sin(2*PI*note/12) + width/2, 200 * -cos(2*PI*note/12) + height/2, 20, 20);
    line(200 * sin(2*PI*pointerb/12) + width/2, 200 * -cos(2*PI*pointerb/12) + height/2, 200 * sin(2*PI*(pointerb + incrementb) /12) + width/2, 200 * -cos(2*PI*(pointerb + incrementb) /12) + height/2);
    countb++;
    if((pointerb + incrementb) % 12 == 0)
      pointerb = (pointerb + 1) % 12;
    incrementb++;
    if(countb > 132){fill(255);
    stroke(255);rect(width/4, 0, 500, 500);fill(68, 98, 74); incrementb = 1; pointerb = 0; countb = 0;}
}
public void eficientDraw()
{
  stroke(68, 98, 74);
  translate(width/2, 0);
  for(int note : notes) //draw each note
    ellipse(200 * sin(2*PI*note/12) + width/2, 200 * -cos(2*PI*note/12) + height/2, 20, 20);
  line(200 * sin(2*PI*pointere/12) + width/2, 200 * -cos(2*PI*pointere/12) + height/2, 200 * sin(2*PI*(pointere + incremente) /12) + width/2, 200 * -cos(2*PI*(pointere + incremente) /12) + height/2);
  incremente++;
  if(12 - incremente == pointere)
  {
    incremente = 1;
    pointere++;
  }
  counte++;
  if(counte > 66){fill(255);
  stroke(255);rect(width/4, 0, 500, 500);fill(68, 98, 74); incremente = 1; pointere = 0; counte = 0;}
}
public void keyPressed()
{
  if(key == 'p')
    paused = !paused;
}