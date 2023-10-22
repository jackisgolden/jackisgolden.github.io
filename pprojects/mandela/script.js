function drawCircle() {
  var canvas = document.getElementById("canvas");
  var ctx = canvas.getContext("2d");
  ctx.beginPath();
  ctx.arc(10, 10, 10, 0, 2 * Math.PI);
  ctx.stroke();
}

function drawRectangle() {
  var canvas = document.getElementById("canvas");
  var ctx = canvas.getContext("2d");
  ctx.strokeRect(10, 10, 30, 30);
}

function drawLine() {
  var canvas = document.getElementById("canvas");
  var ctx = canvas.getContext("2d");
  ctx.beginPath();
  ctx.moveTo(100, 100);
  ctx.lineTo(500, 500);
  ctx.stroke();
}

let circleButton = document.getElementById("circle-btn");
circleButton.addEventListener("click", drawCircle);

let rectangleButton = document.getElementById("rectangle-btn");
rectangleButton.addEventListener("click", drawRectangle);

let lineButton = document.getElementById("line-btn");
lineButton.addEventListener("click", drawLine);
