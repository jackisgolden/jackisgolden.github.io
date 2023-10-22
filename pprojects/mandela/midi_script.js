import MidiPlayer from 'midi-parser-js'

// Set up canvas
const canvas = document.getElementById("myCanvas");
const ctx = canvas.getContext("2d");

// Set up MIDI player
const player = new MidiPlayer.Player();
player.loadFile("arab.mid");
player.on("noteOn", note => {
  // Display note on canvas
  ctx.font = "24px Arial";
  ctx.fillStyle = "black";
  ctx.fillText(note.name, 10, 50);
});

// Start playing MIDI file
player.play();
