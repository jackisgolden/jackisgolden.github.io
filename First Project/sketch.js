let mover;

function setup() {
  let canvas = createCanvas(640, 360);
  canvas.parent('codeSketch');
  mover = new Mover();
}

function draw() {
  background(241,234,213);

  mover.update();
  mover.checkEdges();
  mover.display();
}

function windowResized() {
  centerCanvas();
}

class Mover {
  constructor() {
    this.position = createVector(width / 2, height / 2);
    this.velocity = createVector(1, 0);
    this.acceleration = createVector(0, 0.04);
    this.topspeed = 20;
  }

  update() {
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.topspeed);
    this.position.add(this.velocity);
  }

  display() {
    stroke(0);
    strokeWeight(0);
    fill(216,72,72);
    ellipse(this.position.x, this.position.y, 48, 48);
  }

  checkEdges() {
    if (this.position.x + 24  > width) {
      this.velocity.x *= -1;
    } else if (this.position.x - 24 < 0) {
      this.velocity.x *= -1;
    }

    if (this.position.y + 24 > height) {
      this.velocity.y *= -1;
    } else if (this.position.y - 24 < 0) {
      this.velocity.y *= -1;
    }
  }
}
