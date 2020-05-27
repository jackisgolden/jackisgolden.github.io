float frac = 1.61803398875;//1.61803398875;
int r = 5;
float incr, n;
boolean paused;
public void setup(){
  size(800,800);
  background(255);
  paused = true;
  frameRate(30);
  n = width/(2 * r) - 3;
}

public void draw(){
  background(255);
  if(!paused){
    incr = incr < 0 ? -map(mouseX,0,width,.0001,.001) :  map(mouseX,0,width,.0001,.001);
    frac += incr;
  }
  fill(185,103,255);
     for(int i = 0; i < n; i++){
       ellipse(width/2 + cos(2.0*PI*i*frac)*(i + 1)*r, height/2 + sin(2*PI*i*frac)*(i + 1)*r, 6*r,6*r);
     }
     fill(0);
    text("Fraction:" + frac, 20, 20);
}

public void keyPressed(){
    if(key == 'p')
        paused = !paused;
    else if(key == 'r'){paused  = true; frac = 1.61803398875}
    else if(key == CODED)
        if(keyCode == LEFT)
            incr = incr > 0 ?-incr : incr;
        if(keyCode ==  RIGHT)
            incr = incr < 0 ?-incr : incr;
        if(keyCode == UP && r < 13){r++;n = width/(2 * r) - 3;}
        if(keyCode ==  DOWN && r > 1){r--;n = width/(2 * r) - 3;}
}

