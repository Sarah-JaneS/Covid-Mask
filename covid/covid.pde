import processing.embroider.*;
PEmbroiderGraphics E;

Table covidData;
PImage img;

void setup(){
  
  size(1000,500);
  E = new PEmbroiderGraphics(this,width,height);
  
  
  // For outputting machine in fablab uses .dst
  String outputFilePath = sketchPath("PEmbrioder_template.dst");
  E.setPath(outputFilePath);
  
  background(255);
  noFill();
  
  E.beginDraw();

  covidData = loadTable("covidData.csv", "header");
  E.stroke(0,0,0);         // sets the stroke color, just like Processing.
  E.strokeWeight(5);     // sets the thickness of the stroke (in machine units)
  E.strokeSpacing(1);  // sets the density of the hatching within the stroke
  E.hatchMode(PEmbroiderGraphics.PARALLEL);
  E.hatchAngleDeg(40.0); 
  E.hatchSpacing(5.0); 
  E.setStitch(5, 30, 0.5);
  img = loadImage("bacteriasimple.png");

  E.beginCull();
  for(int i = 0; i < covidData.getRowCount(); i++){
    E.image(img, int(random(1000)), int(random(500)), covidData.getInt(i,"TOTAL")*3, covidData.getInt(i,"TOTAL")*3);
    
  }
  E.endCull();
  //E.optimize();
  E.endDraw();
  
  //Prints everything on screen
  E.visualize(); 
  
}


void draw(){
}
