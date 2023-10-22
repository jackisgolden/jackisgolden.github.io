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

let drawOuter = false;
function toggleLine() {
  drawOuter = !Outer; // toggle the boolean value
}


// calculate the x and y coordinates of each corner
const cornerCoords = [];
for (let i = 0; i < numSides; i++) {
  const angle = (i * Math.PI * 2) / numSides;
  const x = centerX + radius * Math.cos(angle);
  const y = centerY + radius * Math.sin(angle);
  cornerCoords.push({ x, y });
}

// draw the dodecagon
//ctx.beginPath();
//ctx.moveTo(cornerCoords[0].x, cornerCoords[0].y);
//for (let i = 1; i < cornerCoords.length; i++) {
//    ctx.lineTo(cornerCoords[i].x, cornerCoords[i].y);
//}
//ctx.closePath();
//ctx.stroke();

// draw the corners
//for (let i = 0; i < cornerCoords.length; i++) {
//  ctx.beginPath();
//  ctx.arc(cornerCoords[i].x, cornerCoords[i].y, 5, 0, 2 * Math.PI);
//  ctx.fillStyle = '#000';
//  ctx.fill();
//}

ctx.beginPath();
ctx.moveTo(cornerCoords[0].x, cornerCoords[0].y);

// draw circle of fiths
for (let i = 0; i < cornerCoords.length; i++) {
    // Perfect fifth from i
    let V_i = (i + 1) * 7 % 12;
    ctx.lineTo(cornerCoords[V_i].x, cornerCoords[V_i].y);
}
ctx.strokeStyle = 'purple';
ctx.closePath();
ctx.stroke();

ctx.beginPath();
for (let i = 0; i < cornerCoords.length; i++) {
    ctx.moveTo(cornerCoords[i].x, cornerCoords[i].y);
    // Minor third from i
    let iii = (i + 3) % 12;
    // Major third from i
    let III = (i + 4)  % 12;

    ctx.lineTo(cornerCoords[iii].x, cornerCoords[iii].y);
    ctx.moveTo(cornerCoords[i].x, cornerCoords[i].y);
    ctx.lineTo(cornerCoords[III].x, cornerCoords[III].y);
}
ctx.closePath();
ctx.strokeStyle = 'green';
ctx.stroke();
