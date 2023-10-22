const canvas = document.getElementById('myCanvas');
const ctx = canvas.getContext('2d');

// set canvas width and height
canvas.width = 600;
canvas.height = 600;

// set dodecagon specs
const numSides = 12; // number of sides
const centerX = canvas.width / 2; // x-coordinate of center
const centerY = canvas.height / 2; // y-coordinate of center
const radius = 200; // radius of the dodecagon

// calculate the x and y coordinates of each corner
const cornerCoords = [];
for (let i = 0; i < numSides; i++) {
  const angle = (i * Math.PI * 2) / numSides;
  const x = centerX + radius * Math.cos(angle);
  const y = centerY + radius * Math.sin(angle);
  cornerCoords.push({ x, y });
}

let rotationAngle = 0; // initial rotation angle

function draw() {
  // clear canvas
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // calculate new corner coordinates with rotation
  const rotatedCoords = [];
  for (let i = 0; i < cornerCoords.length; i++) {
    const { x, y } = cornerCoords[i];
    const rotatedX = centerX + (x - centerX) * Math.cos(rotationAngle) - (y - centerY) * Math.sin(rotationAngle);
    const rotatedY = centerY + (x - centerX) * Math.sin(rotationAngle) + (y - centerY) * Math.cos(rotationAngle);
    rotatedCoords.push({ x: rotatedX, y: rotatedY });
  }

  // draw the dodecagon
  ctx.beginPath();
  ctx.moveTo(rotatedCoords[0].x, rotatedCoords[0].y);
  for (let i = 1; i < rotatedCoords.length; i++) {
    ctx.lineTo(rotatedCoords[i].x, rotatedCoords[i].y);
  }
  ctx.closePath();
  ctx.strokeStyle = 'black';
  ctx.stroke();

  // draw the corners
  //for (let i = 0; i < rotatedCoords.length; i++) {
  //  ctx.beginPath();
  //  ctx.arc(rotatedCoords[i].x, rotatedCoords[i].y, 5, 0, 2 * Math.PI);
  //  ctx.fillStyle = '#000';
  //  ctx.fill();
  //}

  ctx.beginPath();
  // draw circle of fifths
  for (let i = 0; i < rotatedCoords.length; i++) {
    let V = (i + 1) * 7 % 12;
    ctx.lineTo(rotatedCoords[V].x, rotatedCoords[V].y);
  }
  ctx.strokeStyle = 'purple';
  ctx.closePath();
  ctx.stroke();
  // update rotation angle
  rotationAngle += 0.01;
  // request next frame
  requestAnimationFrame(draw);
}

// start animation
requestAnimationFrame(draw);
