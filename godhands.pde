import processing.video.*;
import javax.swing.*;




OBJ j;
//
// UPDATE THIS TO INCLUDE THE ABSOLUTE PATH IN YOUR COMPUTER!
//
PGraphics left, right;
Anaglyph a = new Anaglyph(left, right); // the anaglyph object
Capture camera; // the webcam
SimpleMotionDetection md; // the motion detection object
PImage prev; // the previous frame

// the bars that change the parameters
ScrollBar scaleBar;
ScrollBar tresholdBar;
ScrollBar blockSizeBar;

float scale;
int offset;

// File Chooser
JFileChooser fc = new JFileChooser();
int fcValue;


void setup() {
  size(600, 620, P3D);

  // File Chooser
  fcValue = fc.showOpenDialog(this);
  if(fcValue == JFileChooser.APPROVE_OPTION) {
    File f = fc.getSelectedFile();
    j = new OBJ(f.getPath());
  } else {
    System.exit(-1);
  }
  

  left = createGraphics(500,500,P3D);
  right = createGraphics(500,500,P3D);

  scaleBar = new ScrollBar(330, 480, "Scale", 100, 100);
  scaleBar.setValue(0.7);
  tresholdBar = new ScrollBar(330, 460, "Sensitivity", 256, 100);
  tresholdBar.setValue(50);
  blockSizeBar = new ScrollBar(330, 440, "Block Size", 50, 100);
  blockSizeBar.setValue(8);

  camera = new Capture(this, 320, 240, 30);
  camera.start();
  md = new SimpleMotionDetection(50);
  prev = createImage(camera.width, camera.height, RGB);

  frameRate(27);
}

/**
 * Draws the frame
*/
void draw() {
  left.beginDraw();
  left.background(0);
  left.noStroke();
  
  // create the light
  left.directionalLight(120, 120, 120, 0, 0, -1);
  left.ambientLight(120, 120, 120);
  
  // setup the geometry of the scene
  left.translate(width/2, height/2);
  left.scale(scale); // scale the object so it's visible
  
  
  // draw the shape
  left.shape(j.getShape(),0,0);
  left.endDraw();
  
  right.beginDraw();
  right.background(0);
  right.noStroke();
  right.directionalLight(120, 120, 120, 0, 0, -1);
  right.ambientLight(120, 120, 120);
  
  // setup the geometry of the scene
  right.translate(width/2, height/2);
  right.scale(scale); // scale the object so it's visible
  right.shape(j.getShape(),-offset,0);
  right.endDraw();

  // update the eyes and display the result
  a.updateLeft(left);
  a.updateRight(right);
  image(a.render(), 0, 0);
  

  /** The motion detection is here **/
  if(camera.available()) {
    prev = createImage(camera.width, camera.height, RGB);
    prev.copy(camera, 0, 0, camera.width, camera.height, 0, 0, camera.width, camera.height);
    prev.updatePixels();
    camera.read();
  }
  md.setPrevious(prev);
  md.setCurrent(camera);

  PImage diff = md.getDiff(); // create the diff image
  PVector motion = md.getOverallMotionVector(); // get the motion vector
  motion.div(500); // reduce the weight it does by 500
  j.boost(new PVector(motion.y, motion.x)); // invert the vector and boost the object

  // Display user
  image(camera, 340, 500, 160, 120);
  image(diff, 0, 500, 160, 120);
  PVector loc = md.getMotionLocation(diff);
  noStroke();
  fill(color(255, 0, 0));
  ellipse(340+loc.x/2, 500+loc.y/2, 5, 5);


  // Display the bars and change the parameters
  scaleBar.show();
  scale = scaleBar.getValue();
  offset = int(30/scale);

  tresholdBar.show();
  md.setTreshold((int) tresholdBar.getValue());

  blockSizeBar.show();
  md.setBlockSize((int) blockSizeBar.getValue());
}


/**
 * Manipulate the object with key presses
 * rotate the object according to the key
 * pressed
*/
void keyPressed() {
  switch(keyCode) {
    case DOWN:
      j.rotateDown(); break;
    case UP:
      j.rotateUp(); break;
    case RIGHT:
      j.rotateRight(); break;
    case LEFT:
      j.rotateLeft(); break;
    case ENTER:
      j.boost(new PVector(random(-0.5,0.5), random(-0.5,0.5))); break;
  }
}
