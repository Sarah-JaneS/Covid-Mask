import processing.embroider.*;
import processing.svg.*;
PEmbroiderGraphics E;
int x;
int y;
Table covidData;
PShape img;

void setup() {
  noLoop();
  size(1750, 875);
  E = new PEmbroiderGraphics(this, width, height);


  // For outputting machine in fablab uses .dst
  String outputFilePath = sketchPath("maskforfinal4.dst");
  E.setPath(outputFilePath);
  E.setOutOfBoundsHandler(E.CROP);
  background(255);
  noFill();

  E.beginDraw();

  covidData = loadTable("covidData.csv", "header");
  //E.stroke(0,0,0);         // sets the stroke color, just like Processing.
  E.strokeWeight(1);     // sets the thickness of the stroke (in machine units)
  E.strokeMode(E.TANGENT);
  E.strokeSpacing(5);  // sets the density of the hatching within the stroke
  E.hatchMode(PEmbroiderGraphics.CONCENTRIC);
  E.hatchAngleDeg(40.0); 
  E.hatchSpacing(5.0); 
  //minimim, ideal, noise
  E.setStitch(15, 30, 0.1);
  //E.fill(0,0,0);
  img = loadShape("bacteriasimple.svg");

  E.beginCull();
  fill(200);
  for (int i = 0; i < covidData.getRowCount(); i++) {
    x=int (random(1750));
    y=int (random(875));
    println(covidData.getInt(i, "TOTAL")*4);
    if (covidData.getInt(i, "TOTAL")*4 >63) {
        E.setStitch(15, 30, 0.1);

      E.shape(img, x, y, covidData.getInt(i, "TOTAL")*4, covidData.getInt(i, "TOTAL")*4);
      println("loop");
    } else {
        E.setStitch(5, 15, 0.1);

      E.ellipse(x, y, covidData.getInt(i, "TOTAL")*4, covidData.getInt(i, "TOTAL")*4);
    }
  }
  E.endCull();



  //Prints everything on screen
  E.visualize(); 
  println("vis");
  E.optimize();
  E.endDraw();
  println("end");
}


void draw() {
}
