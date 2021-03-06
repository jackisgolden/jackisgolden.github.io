
  public static final int[] majors = { 0, 2, 4, 5, 7, 9, 11 };
  public static final int[] minors = { 0, 2, 3, 5, 7, 8, 10 };
  public static final int[] minorp = { 0, 3, 5, 7, 10 };
  public static final int[] majorp = { 0, 2, 5, 7, 9 }; // these are rootless shapes. shift to align with different roots on guitar..
  public static final int[] majorc = { 0, 4, 7 };
  public static final int[] minorc = { 0, 3, 7 };
  public static final int[] chromatics = {0,1,2,3,4,5,6,7,8,9,10,11};
  public static final int[] root = { 0 };
  int[] ionians = { 0, 2, 4, 5, 7, 9, 11 };

  NoteSet majorScale = new NoteSet(majors, "Major Scale");
  NoteSet minorScale = new NoteSet(minors, "Minor Scale");
  NoteSet majorPent = new NoteSet(majorp, "Major Pentatonic");
  NoteSet minorPent = new NoteSet(minorp, "Minor Pentatonic");
  NoteSet majorChord = new NoteSet(majorc, "Major Chord");
  NoteSet minorChord = new NoteSet(minorc, "Minor Chord");
  NoteSet chromaticScale = new NoteSet(chromatics, "Chromatic scale");
  NoteSet ionian =  new NoteSet(ionians, "Ionian");

  public static final NoteSet[] scales = { majorScale, minorScale, majorPent, minorPent, majorChord, minorChord, chromaticScale, ionian};
  public static final String[] allNotes = { "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#" };

  int scale = 0; // ************CHOOSE YOUR SCALE**********************
  int keyRoot = 0; // ***CHOSE YOUR KEY, STARTS ON E********

  public static final int[] ukeN = { 5, 0, 8, 3 };
  public static final int[] bassN = { 3, 10, 5, 0 };
  public static final int[] guitarN = { 0, 7, 3, 10, 5, 0 }; // in reverse order because processing renders positive y downwards
  public static final int[] banjoN = {11, 10 ,3, 7, 10};
  public static final int[] linnstrN= {0, 5, 10, 3, 8, 1, 6, 11};      //has 25 columns to play
  public static final int[] harpejjN = { 5, 7, 9, 11, 1, 3, 5, 7, 9, 11, 1, 3, 5, 7, 9, 11, 1, 3, 5, 7, 9,11, 1, 3};

  NoteSet guitar = new NoteSet(guitarN, "Guitar");
  NoteSet bass = new NoteSet(bassN, "Bass");
  NoteSet ukulele = new NoteSet(ukeN, "Ukulele");
  NoteSet banjo = new NoteSet(banjoN, "Banjo");
  NoteSet linnstrument = new NoteSet(linnstrN, "Linnstrument");
  NoteSet harpejji = new NoteSet(harpejjN, "Harpejji");

  NoteSet[] instruments = { guitar, bass, ukulele, banjo, linnstrument, harpejji };
  int instrument = 0; // ************CHOOSE YOUR INSTRUMENT**********************

  int startpointx, startpointy, lengthx, lengthy, nFrets; // 17 frets, 5 strings.

  public static final String[] modes = {"Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"};
  int mode = 0;

  boolean rainbowMode = false;

  public void setup() {
    size(1200, 800);   //1200, 600
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
    background(255);
    renderStrings();
    renderText();
    renderNotes();
  }

  public void keyPressed() {
    if (key == 'i') // switch instrument
      instrument = (instrument + 1) % instruments.length;
    else if (key == 's' && scale != scales.length - 1) // switch scale
      scale = (scale + 1) % (scales.length - 1);  //we want to exclude the ionian mode
    else if(key == 'r')
      rainbowMode = !rainbowMode;
    else if(key == 'm')
      scale = scale == (scales.length - 1) ? 0 : scales.length - 1;
    else if (key == CODED) // left right arrow keys move KEY of song
      if (keyCode == LEFT)
        keyRoot = (keyRoot + 1) % 12;
      else if (keyCode == RIGHT)
          keyRoot = (keyRoot - 1 + 12) % 12; 
      else if (keyCode == UP && scale == scales.length -  1)
        scales[scale].modulate(true);
      else if (keyCode == DOWN && scale == scales.length -  1)
        scales[scale].modulate(false);
  }

  public void renderStrings() {
    fill(0);
    stroke(0);
    for (int string = 0; string < instruments[instrument].getLength(); string++) {
      int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
      line(startpointx, ycord, startpointx + lengthx, ycord);
    }

    for (int fret = 0; fret < nFrets; fret++) {   //linear render
      int xcord = startpointx + fret * lengthx / (nFrets - 1);
      if (fret == 0) {
        strokeWeight(5);
        line(xcord, startpointy, xcord, startpointy + lengthy);
        strokeWeight(1);
      }
      line(xcord, startpointy, xcord, startpointy + lengthy);
    }

  //  double scaleFactor = (double)lengthx / (lengthFromFretToBridge(40) -  lengthFromFretToBridge(40 + nFrets));
  //    for (int fret = 0; fret < nFrets; fret++) {      //exponential render
  //     int pitch = fret + 40;
  //     int xcord = (int)((double)startpointx + (double)lengthx - lengthFromFretToBridge(pitch) * scaleFactor);
  //     if (fret == 0) {
  //       strokeWeight(5);
  //       line(xcord, startpointy, xcord, startpointy + lengthy);
  //       strokeWeight(1);
  //     }
  //     line(xcord, startpointy, xcord, startpointy + lengthy);
  //   }

    int[] markings = { 3, 5, 7, 9, 12, 15, 17, 19, 21 };
    int ycord = startpointy + lengthy / 2;
    for (int u : markings) {
      int xcord = startpointx + (u - 1) * lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
      noStroke();
      fill(0);
      ellipse(xcord, ycord, 5, 20);
    }
    stroke(1);
  }

  public void renderText() {
    textAlign(CENTER, CENTER);
    fill(0);
    textSize(20);
    for (int string = 0; string < instruments[instrument].getLength(); string++) {
      int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
      int xcord = startpointx + (- 1)* lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
      text(allNotes[instruments[instrument].get(string)], xcord, ycord);
    }
    textSize(20);
    text("Instrument: " + instruments[instrument], 100, 20);
    text((scale == scales.length - 1 ? "Modes" : "Scales") + " Active", 1100, 20);

    textSize(40);
    text(allNotes[(12 - keyRoot) % 12] + " " + scales[scale], width / 2, height / 8);
  }

  public void renderNotes() {
    for (int string = 0; string < instruments[instrument].getLength(); string++)
      for (int fret = 0; fret < nFrets; fret++)
        if (scales[scale].containsNote((instruments[instrument].get(string) + fret + keyRoot) % 12)) {
          int xcord = startpointx + (fret - 1)* lengthx / (nFrets - 1) + lengthx / (nFrets * 2);
          int ycord = startpointy + string * lengthy / (instruments[instrument].getLength() - 1);
          boolean inboundx = xcord < mouseX + 2 * lengthx / nFrets && xcord > mouseX - 3 * lengthx / nFrets;
          boolean inboundy = mouseY < startpointy + lengthy && mouseY > startpointy;
          int opacity = fret == 0 ? 100 : 255;
          if(!rainbowMode){
            fill(200, 200, 200, opacity);
            if (inboundx && inboundy) 
              fill(0, 255, 0, opacity);
            if ((fret + instruments[instrument].get(string) + keyRoot) % 12 == 0)
              fill(255, 0, 0, opacity);
          }
          if(rainbowMode){
            colorMode(HSB, 360, 100, 100, 255);
            int saturation = 50;
            if (inboundx && inboundy) 
              saturation = 100;
            fill((instruments[instrument].get(string) + fret + keyRoot) % 12 *30, saturation, 100, opacity);
          }
          ellipse(xcord, ycord, 20, 20);
          colorMode(RGB, 255, 255, 255);
        }
  }
  public double lengthFromFretToBridge(int pitch)
  {
      return 108.0 / (440.0 * Math.exp(2,((double)pitch - 69.0)/12.0));
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

  public void modulate(boolean up){
    mode = (mode + (up ? 1  : -1) + modes.length)%modes.length;
    this.name = modes[mode];
    int shift = notes[up ? 1 : notes.length - 1];
    if(up){
      for(int i = notes.length - 1; i > 0; i--) //up
      {  
        int temp = notes[i];
        notes[i] = notes[i - 1];
        notes[i - 1] = temp;
      }
    }
    else {
      for(int i = 0; i < notes.length; i++) //down
      {  
        int temp = notes[i];
        notes[i] = notes[(i  + notes.length - 1)% notes.length];
        notes[(i  + notes.length - 1)% notes.length] = temp;
      }
    }
    for(int i = 0; i < notes.length; i++)
      notes[i] =  (notes[i] - shift + 12) % 12;
  }
}
private class Instrument extends NoteSet{
  private int frets;
  private boolean linearFretSpacing;
  public Instrument(int[] notes, String name, int frets, boolean linearFretSpacing) {
    super(notes, name);
    this.frets = frets;
    this.linearFretSpacing = linearFretSpacing;
  }
  public Instrument(int[] notes, String name, int frets) {
    this.notes = notes;
    this.name = name;
    this.frets = frets;
  }

  public Instrument() {
    super();
  }
}