float frac = 1.61803398875;
int r = 10;
float incr;
boolean paused;
public void setup(){
  size(800,800);
  background(255);
  paused = true;
  frameRate(30);
}

public void draw(){
  background(255);
  if(!paused){
    incr = map(mouseX,0,width,.0001,.001);
    frac += incr;
  }
  fill(185,103,255);
     for(int i = 0; i < 30; i++){
       ellipse(width/2 + cos(2.0*PI*i*frac)*(i + 1)*r, height/2 + sin(2*PI*i*frac)*(i + 1)*r, 40,40);
     }
     fill(0);
    text("Fraction:" + frac, 20, 20);
}

public void keyPressed(){
    if(key  = 'p')
        paused = !paused;
}

