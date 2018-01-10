 /**
 * Example of co-centric circles plus Perlin Noise
 */
int version = 0; //if we grab multiple frames, they will be numbered
float timeSeed = 0.6; //seed for the third dimension of the noise
PVector l1, l2; //two points for our lines

import processing.pdf.*;

boolean saveOneFrame = false;

void setup() {
  size(1000, 1000); //resolution does not really matter since we are working with vectors
  frameRate(24);
  smooth();
}

void draw() {
  if(saveOneFrame == true) { //turn on recording for this frame if we clicked the mouse
    beginRecord(PDF, "Line_"+version+".pdf"); 
  }
  
  background(255);
  noFill();
  stroke(0);
  strokeWeight(1);
  translate(width/2, height/2); //start at the middle of the canvas
  //timeSeed = millis()/2000.0; //change noise over time
  
  for(float dia = 10.0; dia< width; dia+=10.0){ //iterate the diameter of the circles bigger
    beginShape();
    float div = 2.0*PI/(dia/2.0); //divide 2PI over the number of sides
    for(float a = 0; a<=2.0*PI; a+=div){ //iterate around the circle
      float x = (cos(a)*dia); //change polar coordinates to cartesian
      float y = (sin(a)*dia);
      x += 400.0* noise(x/200.0, y/200.0, timeSeed)-200; //add some noise to change the position
      y += 400.0* noise(x/200.0, y/200.0, timeSeed)-200;
      vertex(x, y); //add a point to the circle
    }
    endShape(CLOSE);
  }
  
  if(saveOneFrame == true) {
    endRecord();
    version++;
    saveOneFrame = false; 
  }
}

void mousePressed() {
  saveOneFrame = true; 
}