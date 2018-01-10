/**
 * Example of using noise to rotate a grid of arrows
 */
int version = 0; //if we grab multiple frames, they will be numbered
float timeSeed = 0.1; //seed for the third dimension of the noise

import processing.pdf.*;

boolean saveOneFrame = false;

void setup() {
  size(1000, 1000); //resolution does not really matter since we are working with vectors
  frameRate(24);
  smooth();
}

void draw() {
  if (saveOneFrame == true) { //turn on recording for this frame if we clicked the mouse
    beginRecord(PDF, "Line_"+version+".pdf");
  }

  background(255);
  noFill();
  stroke(0);
  strokeWeight(1);
  timeSeed = millis()/5000.0; //change noise over time
  for (int cy = 40; cy < height; cy+=40) { //iterate down the page
    for (int cx = 40; cx < width; cx+=40) { //iterate across the page
      pushMatrix();
      translate(cx, cy); //set the position of each arrow
      rotate(4.0*PI*noise(cx/400.0, cy/400.0, timeSeed)); //rorate using noise
      scale(1); 
      arrow(); //draw our arrow
      popMatrix();
    }
  }
  if (saveOneFrame == true) {
    endRecord();
    version++;
    saveOneFrame = false;
  }
}

void mousePressed() {
  saveOneFrame = true;
}

void arrow() { //custom shape for our arrow
  beginShape();
  vertex(0, -55);
  vertex(6, 0);
  vertex(16, 10);
  vertex(2, 10);
  vertex(0, -10);
  vertex(-2, 10);
  vertex(-16, 10);
  vertex(-6, 0);
  vertex(0, -55);
  endShape();
}