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
  color c = nextColor(); // next color
  
  background(0);
  noStroke();
  
  // create the light
  directionalLight(red(c), green(c), blue(c), 0, 0, -1);
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



/**
 * Generate the next color in the color wheel
 * depends on the global iter value
 *
 * @return          next color in the color wheel
*/
int iter = 0;
color nextColor() {
  iter = (iter+1)%1000;
  int r = 255 - (int) min(255,max(0,638.5-2.1*abs(iter-500)));
  int g = (int) max(0,min(255 - abs(1.25*(iter-335))+333/2,255));
  int b = (int) max(0,min(255 - abs(1.25*(iter-600))+333/2,255));
  return color(r,g,b);
}
