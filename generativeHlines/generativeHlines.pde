 /**
 * Example of generative piece using horizontal lines and Perlin Noise
 */
int version = 0; //if we grab multiple frames, they will be numbered
float timeSeed = 0.6; //seed for the third dimension of the noise
PVector l1, l2; //two points for our lines

import processing.pdf.*;

boolean saveOneFrame = false;

void setup() {
  size(1000, 1000); //resolution does not really matter since we are working with vectors
  frameRate(24);
  l1 = new PVector(0,0); //setup our points
  l2 = new PVector(0,0);
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
    l1.set(0, j+(noise(0, j/300.0, timeSeed)*1000.0)-500.0); //reset the initial point at the start of each new line
    for(float i = 0; i<width+40; i+=40){ //iterate across the page
      l2.set(i, j+(noise(i/300.0, j/300.0, timeSeed)*1000.0)-500.0); //set the next point in the line
      line(l1.x, l1.y, l2.x, l2.y); //draw a line from the last point to the new one
      l1=l2.copy(); //copy the new point into the old variable for the next loop
    }
  }
  
  if(saveOneFrame == true) {
    endRecord();
    saveOneFrame = false; 
  }
}

void mousePressed() {
  saveOneFrame = true; 
}