OBJ j;
//
// UPDATE THIS TO INCLUDE THE ABSOLUTE PATH IN YOUR COMPUTER!
//
String location = "/home/euler/sketchbook/project/"; 

void setup() {
  j = new OBJ(location+"icosahedron.obj");
  size(500, 500, P3D);
}


/**
 * Draws the frame
*/
void draw() {
  background(0);
  noStroke();
  
  // create the light
  directionalLight(120, 120, 120, 0, 0, -1);
  ambientLight(120, 120, 120);
  
  // setup the geometry of the scene
  translate(width/2, height/2);
  scale(80); // scale the object so it's visible
  
  // draw the shape
  shape(j.getShape(),0,0);
  
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
