 /**
 * Example of generative piece using horizontal lines and Perlin Noise
 **This version makes continuous lines as opposed to diagonal fragments
 */
int version = 0; //if we grab multiple frames, they will be numbered
float timeSeed = 0.6; //seed for the third dimension of the noise

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
  
  //timeSeed = millis()/2000.0; //change noise over time
  background(255);
  noFill();
  stroke(0);
  strokeWeight(1);
  
  for(int j = -100; j< height*2; j+=5){ //iterate down the page
    beginShape();
    vertex(0, j+(noise(0, j/300.0, timeSeed)*1000.0)-500.0); //reset the initial point at the start of each new line
    for(float i = 10; i<width+40; i+=40){ //iterate across the page
      vertex(i, j+(noise(i/300.0, j/300.0, timeSeed)*1000.0)-500.0); //set the next point in the line
    }
    endShape();
  }
  
  if(saveOneFrame == true) {
    endRecord();
    saveOneFrame = false; 
  }
}

void mousePressed() {
  saveOneFrame = true; 
}