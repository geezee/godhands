OBJ j;
//
// UPDATE THIS TO INCLUDE THE ABSOLUTE PATH IN YOUR COMPUTER!
//
String location = "/home/euler/sketchbook/project/assets/"; 
PGraphics left, right;
Anaglyph a = new Anaglyph(left, right);


void setup() {
  j = new OBJ(location+"eiffel.obj");
  size(500, 500, P3D);
  left = createGraphics(500,500,P3D);
  right = createGraphics(500,500,P3D);
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
  right.shape(j.getShape(),-20,0);
  right.endDraw();

  a.updateLeft(left);
  a.updateRight(right);
  
  image(a.render(), 0, 0);
  
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
