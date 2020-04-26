
  int[] majors = { 0, 2, 4, 5, 7, 9, 11 };
  int[] minors = { 0, 2, 3, 5, 7, 8, 10 };
  int[] minorp = { 0, 3, 5, 7, 10 };
  int[] majorp = { 0, 2, 5, 7, 9 }; // these are rootless shapes. shift to align with different roots on guitar..
  int[] majorc = { 0, 4, 7 };
  int[] minorc = { 0, 3, 7 };
  int[] root = { 0 };

  NoteSet majorScale = new NoteSet(majors, "Major Scale");
  NoteSet minorScale = new NoteSet(minors, "Minor Scale");
  NoteSet majorPent = new NoteSet(majorp, "Major Pentatonic");
  NoteSet minorPent = new NoteSet(minorp, "Minor Pentatonic");
  NoteSet majorChord = new NoteSet(majorc, "Major Chord");
  NoteSet minorChord = new NoteSet(minorc, "Minor Chord");

  int[] dorianp = {0, 2, 4, 5, 7, 9, 11};

  NoteSet Dorian = new NoteSet();

  NoteSet[] scales = { majorScale, minorScale, majorPent, minorPent, majorChord, minorChord };
  String[] allNotes = { "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#" };

  int scale = 0; // ************CHOOSE YOUR SCALE**********************
  int keyRoot = 0; // ***CHOSE YOUR KEY, STARTS ON E

  int[] ukeN = { 5, 0, 8, 3 };
  int[] bassN = { 3, 10, 5, 0 };
  int[] guitarN = { 0, 7, 3, 10, 5, 0 }; // in reverse order because processing renders positive y downwards
  int[] banjoN = {11, 10 ,3, 7, 10};
  int[] linnstrN= {0, 5, 10, 3, 8, 1, 6, 11};      //has 25 columns to play
  int[] harpejjN = { 5, 7, 9, 11, 1, 3, 5, 7, 9, 11, 1, 3, 5, 7, 9, 11, 1, 3, 5, 7, 9,11, 1, 3};

  NoteSet guitar = new NoteSet(guitarN, "Guitar");
  NoteSet bass = new NoteSet(bassN, "Bass");
  NoteSet ukulele = new NoteSet(ukeN, "Ukulele");
  NoteSet banjo = new NoteSet(banjoN, "Banjo");
  NoteSet linnstrument = new NoteSet(linnstrN, "Linnstrument");
  NoteSet harpejji = new NoteSet(harpejjN, "Harpejji");

  NoteSet[] instruments = { guitar, bass, ukulele, banjo, linnstrument, harpejji };
  int instrument = 0; // ************CHOOSE YOUR INSTRUMENT**********************

  int startpointx, startpointy, lengthx, lengthy, nFrets; // 17 frets, 5 strings.

  String[] modes = {"Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"};
  int mode = 0;


  public void setup() {
        size(1400, 800);   //1200, 600
    nFrets = 23;
    startpointx = width / 12;
    startpointy = height / 4;

    lengthx = 10 * width / 12;
    lengthy = height / 2;
    background(0);
    renderStrings();
    renderText();
  }

  public void draw() {
    background(0);
    renderStrings();
    renderText();
    renderNotes();
  }

  public void keyPressed() {
    if (key == 'i') // switch instrument
      instrument = (instrument + 1) % instruments.length;
    else if (key == 's') // switch scale
      scale = (scale + 1) % scales.length;
    else if(key == 'm'){ //modulate
      mode = (mode + 1) % modes.length;

    }
    else if (key == CODED) // left right arrow keys move KEY of song
      if (keyCode == LEFT)
        keyRoot = (keyRoot + 1) % 12;
      else if (keyCode == RIGHT)
        if (keyRoot == 0)
          keyRoot = 11;
        else
          keyRoot = (keyRoot - 1) % 12; // fix this
  }

  public void renderStrings() {
    fill(255);
    stroke(255);
    for (int string = 0; string < instruments[instrument].getLength(); string++) {
      int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
      line(startpointx, ycord, startpointx + lengthx, ycord);
    }

    for (int fret = 0; fret < nFrets; fret++) {
      int xcord = startpointx + fret * lengthx / (nFrets - 1);
      if (fret == 0) {
        strokeWeight(5);
        line(xcord, startpointy, xcord, startpointy + lengthy);
        strokeWeight(1);

      }
      line(xcord, startpointy, xcord, startpointy + lengthy);
    }

    int[] markings = { 3, 5, 7, 9, 12, 15, 17, 19, 21 };
    int ycord = startpointy + lengthy / 2;
    for (int u : markings) {
      int xcord = startpointx + (u - 1) * lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
      noStroke();
      fill(255);
      ellipse(xcord, ycord, 5, 20);
    }
    stroke(1);
  }

  public void renderText() {
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(20);
    for (int string = 0; string < instruments[instrument].getLength(); string++) {
      int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
      int xcord = startpointx + (- 1)* lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
      text(allNotes[instruments[instrument].get(string)], xcord, ycord);
    }
    textSize(20);
    text("Instrument: " + instruments[instrument], 100, 20);

    textSize(40);
    text(allNotes[(12 - keyRoot) % 12] + " " + scales[scale], width / 2, height / 8);
  }

  public void renderNotes() {
    for (int string = 0; string < instruments[instrument].getLength(); string++) // note is given by (fret +
                                            // stringNote + keyRoot) % 12
      for (int fret = 0; fret < nFrets; fret++)
        if (scales[scale].containsNote((instruments[instrument].get(string) + fret + keyRoot) % 12)) {
          int xcord = startpointx + (fret - 1)* lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
          int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
          int opacity = fret == 0 ? 100 : 255;
          fill(200, 200, 200, opacity);
          if (xcord < mouseX + 2 * lengthx / nFrets && xcord > mouseX - 3 * lengthx / nFrets
              && mouseY < startpointy + lengthy && mouseY > startpointy) // mouse must be inside fret
                                            // board
            fill(0, 255, 0, opacity);
          if ((fret + instruments[instrument].get(string) + keyRoot) % 12 == 0)
            fill(255, 0, 0, opacity);
          ellipse(xcord, ycord, 20, 20);
        }
  }
  
  private class NoteSet {
  private int[] notes;
  private String name;

  public NoteSet(int[] notes, String name) {
    this.notes = notes;
    this.name = name;
  }

  public NoteSet() {

  }

  public int getLength() {
    return notes.length;
  }

  public int get(int i) {
    return notes[i];
  }
  
  public boolean containsNote(int i){
    for(int u : notes)
      if(i == u)
        return true;
    return false;
  }

  public String toString() {
    return name;
  }

  public void modulate(){
    for(int i = 0; i < notes.length; i++)
    {
      int temp = notes[i];
      notes[i] = notes[(i + 1) % 12];
      notes[(i + 1) % 12] = temp;

      notes[i] = (notes[i] - notes[0]) % 12;
    }

  }
}
