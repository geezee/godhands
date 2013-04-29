import processing.video.*;

OBJ j;
//
// UPDATE THIS TO INCLUDE THE ABSOLUTE PATH IN YOUR COMPUTER!
//
String location = "/home/euler/sketchbook/project/assets/"; 
PGraphics left, right;
Anaglyph a = new Anaglyph(left, right); // the anaglyph object
Capture camera; // the webcam
SimpleMotionDetection md; // the motion detection object
PImage prev; // the previous frame


void setup() {
  j = new OBJ(location+"eiffel.obj");
  size(600, 620, P3D);
  left = createGraphics(500,500,P3D);
  right = createGraphics(500,500,P3D);

  camera = new Capture(this, 320, 240, 30);
  camera.start();
  md = new SimpleMotionDetection(70);
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
  left.scale(0.7); // scale the object so it's visible
  
  
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
  right.scale(0.7); // scale the object so it's visible
  right.shape(j.getShape(),-30,0);
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
  PVector loc = md.getMotionLocation();
  noStroke();
  fill(color(255, 0, 0));
  ellipse(340+loc.x/2, 500+loc.y/2, 5, 5);
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
