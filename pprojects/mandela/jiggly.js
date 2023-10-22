let canvas = document.getElementById('myCanvas');
canvas.width = 300;
canvas.height = 300;
const ctx = canvas.getContext('2d');
const centerX = canvas.width / 2;
const centerY = canvas.height / 2;
const radius = canvas.width / 2.2;
const amplitude = 30;
const frequency = 2 * Math.PI / canvas.width;
const jiggleAmplitude = 10;
const jiggleFrequency = 0.03;
const jiggleTimeFactor = 0.1;
let time = 0;

function draw() {
  // clear the canvas
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // calculate the x and y coordinates of the dodecagon points
  let coords = [];
  let angle = 0;
  for (let i = 0; i < 12; i++) {
    let x = centerX + radius * Math.cos(angle);
    let y = centerY + radius * Math.sin(angle);
    coords.push({ x: x, y: y });
    angle += Math.PI / 6;
  }

  // draw the fluctuating dodecagon with jiggling line segments
  ctx.beginPath();
  for (let i = 0; i < coords.length; i++) {
    let startPoint = coords[i];
    let endPoint = coords[(i + 1) % coords.length];
    let midX = (startPoint.x + endPoint.x) / 2;
    let midY = (startPoint.y + endPoint.y) / 2 + 5 * jiggleAmplitude * Math.sin(midX * jiggleFrequency + time * jiggleTimeFactor);
    if (i === 0) {
      ctx.moveTo(startPoint.x, startPoint.y);
    }
    ctx.quadraticCurveTo(midX, midY, endPoint.x, endPoint.y);
  }
  ctx.closePath();
  
  // set line color and width
  ctx.strokeStyle = 'blue';
  ctx.lineWidth = 3;
  ctx.stroke();

  ctx.beginPath();
  for (let i = 0; i < coords.length; i++) {
	let index = (i + 1) * 7 % 12;
    let startPoint = coords[index];
    let endPoint = coords[(index + 1) % coords.length];
    let midX = (startPoint.x + endPoint.x) / 2;
    let midY = (startPoint.y + endPoint.y) / 2 + 5 * jiggleAmplitude * Math.sin(midX * jiggleFrequency + time * jiggleTimeFactor);
    if (i === 0) {
      ctx.moveTo(startPoint.x, startPoint.y);
    }
    ctx.quadraticCurveTo(midX, midY, endPoint.x, endPoint.y);
  }
  ctx.strokeStyle = 'green';
  ctx.stroke();
  time += 0.1;

  // call this function again on the next animation frame
  requestAnimationFrame(draw);
}

// start the animation loop
requestAnimationFrame(draw);
