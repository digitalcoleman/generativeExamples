/**
 * Example of a grid of decagons with perlin noise
 */
int version = 0; //if we grab multiple frames, they will be numbered
float timeSeed = 0.1; //seed for the third dimension of the noise
float noiseStr = 80.0; //strength of the noise effect

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
  for (int cy = 0; cy < height+100; cy+=50) { //iterate down the page
    for (int cx = 0; cx < width+100; cx+=50) { //iterate across the page
      beginShape();
      float div = 2.0*PI/10.0; //divide 2PI into 1/10ths
      for (float a = 0; a<=2.0*PI; a+=div) { //work around the circle
        float x = (cos(a)*60) + cx; //convert polar to cartesian
        float y = (sin(a)*60) + cy;
        x += noiseStr* noise(x/150.0, y/150.0 + timeSeed*2, timeSeed)-100; //add noise to each point
        y += noiseStr* noise(x/150.0, y/150.0 + timeSeed*2, timeSeed)-100;
        vertex(x, y); //add the point to the shape
      }
      endShape(CLOSE);
    }
  }
  if (saveOneFrame == true) {
    endRecord();
    saveOneFrame = false;
  }
}

void mousePressed() {
  saveOneFrame = true;
}