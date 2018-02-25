let xoff = 0;
let xincrement = 0.01;
let p = 0;

function setup() {
  createCanvas(1440, 360);
  background(255);
  noStroke();
  frameRate(30);
}

function draw() {
  background(100, 251, 255, 5);
  //var n = random(0,width);  // Try this line instead of noise
  let n = noise(xoff);

  let x = map(n, 0, 1, 0, width);
  // With each cycle, increment xoff
  xoff += xincrement;
  // Draw the ellipse at the value produced by perlin noise
  p++;
  fill(255);
  ellipse(x, height / 2 + sin(frameCount) * random(0, 50), 44, 32);
}
