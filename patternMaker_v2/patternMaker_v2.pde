import controlP5.*; //add the GUI library
import drop.*; //add the drag and drop library
import processing.pdf.*; //add the pdf library

SDrop drop; //make an instance of the sDrop library

PShape myShape; //make a shape variable to hold the svg file

ControlFrame cf; //will help us make a second window for the controls

int space = 40; //some initial settings = spacing
float scl = 40.0; //the scale of each object
float noiseScale = 200.0; //the scale of the noise (how smooth)
float noiseEffect = 0.0; //the strength of the noise affecting the position
float noiseRot = 0.0; //the strength of the noise affecting the rotation
float seed = 1; //the noise seed
boolean pdf = false;
int pdfCount = 1; //starting number for the exported pdf

void settings(){
  size(800, 800); //setup our stage/canvas
}

void setup(){
  noFill();
  smooth();
  rectMode(CENTER); //for the starting rectangles, center them
  cf = new ControlFrame(this, 300, 300, "Controls"); //make a new window at 300 wide and 300 tall
  surface.setLocation(320, 10); //move the main window over to make room for the control window
  drop = new SDrop(this); //setup the drag and drop
}

void draw(){
  background(255);
  
  if(pdf)beginRecord(PDF, "pattern" + pdfCount + ".pdf"); //if the button is pressed, begin recording to make the pdf
  noFill();
  for(int x = space/2; x < width; x+= space) { //iterate across the canvas
    for(int y = space/2; y < width; y+= space) { //iterate down the canvas
      float nx = x + noiseEffect * 2*(noise(seed, y/noiseScale, x/noiseScale)-0.5); //compute the x position noise
      float ny = y + noiseEffect * 2*(noise(x/noiseScale, seed, y/noiseScale)-0.5); //compute the y position noise
      float rot = 4 * PI * (noise(x/noiseScale, y/noiseScale, seed)-0.5) * noiseRot; //compute the rotation noise
      pushMatrix();
      translate(nx, ny); //move the shape into place
      rotate(rot); //rotate the shape
      //scale(scl);
      if(myShape !=null){ //if we have dropped on an svg, then use it
        shape(myShape, 0, 0, scl, scl); //draw the svg
      }else{
        rect(0, 0, scl, scl); //otherwise, use some squares
        //ellipse(0, 0, scl, scl); //or some ellipses
      }
      popMatrix();
    }
  }
  if(pdf) {
    endRecord();
    pdfCount++;
    pdf = false;
  }
}

void dropEvent(DropEvent theDropEvent) { //this takes care of the drag and drop
   if(theDropEvent.isFile()) {
    // for further information see
    // http://java.sun.com/j2se/1.4.2/docs/api/java/io/File.html
      String myFile = theDropEvent.filePath(); //get the filepath
      myShape = loadShape(myFile); //load the svg into our shape variable
   }
}

//everything below this makes the control window

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }

  public void setup() {
    surface.setLocation(10, 10);
    cp5 = new ControlP5(this);
       
    cp5.addSlider("spacing")
       .plugTo(parent, "space")
       .setRange(1, 400)
       .setValue(40)
       .setPosition(20, 20)
       .setSize(200, 30);
       
    cp5.addSlider("scaling")
       .plugTo(parent, "scl")
       .setRange(10.0, 400.0)
       .setValue(40.0)
       .setPosition(20, 60)
       .setSize(200, 30); 
       
    cp5.addSlider("noise scale")
       .plugTo(parent, "noiseScale")
       .setRange(20.0, 1000.0)
       .setValue(200.0)
       .setPosition(20, 100)
       .setSize(200, 30);
       
    cp5.addSlider("noise effect - pos")
       .plugTo(parent, "noiseEffect")
       .setRange(0.0, 300.0)
       .setValue(0.0)
       .setPosition(20, 140)
       .setSize(200, 30);
       
    cp5.addSlider("noise effect - rot")
       .plugTo(parent, "noiseRot")
       .setRange(0.0, 1.0)
       .setValue(0.0)
       .setPosition(20, 180)
       .setSize(200, 30);
       
    cp5.addSlider("noise seed")
       .plugTo(parent, "seed")
       .setRange(0.0, 10.0)
       .setValue(0.0)
       .setPosition(20, 220)
       .setSize(200, 30);
       
    cp5.addButton("exportPDF")
       .plugTo(parent, "pdf")
       .setSwitch(false)
       .setPosition(20, 260)
       .setSize(50, 30);
  }

  void draw() {
    background(190);
  }
  
}