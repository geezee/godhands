/**
 *  OBJ class loades the .obj and creates
 *  a wrapper that is easy to control
*/
class OBJ {
  
  private float step = 0.1; // step to rotate
  private float elasticity = 0.95; // elasticity of the object
  private PShape shape; // the shape
  private PVector acceleration = new PVector(0,0); // the acceleration of the object

  
  /**
   * Constructor
   * @param l      Location of the obj file
  */
  OBJ(String l) {
    shape = loadShape(l);
  }

  
  /**
   * Returns the shape that is loaded
   * and updates it
   *
   * @return PShape  The shape that is used
  */
  PShape getShape() {
    update(); // before getting, update the shape
    return shape;
  }

  /**
   * Returns the shape that was loaded
   * without updating it
   *
   * @return PShape  The shape that is used
  */
  PShape shape() {
      return shape;
  }

  
  /**
   * Method that boosts the object giving it an
   * acceleration to turn with
   * @param a        The acceleration to boost the object with
  */
  void boost(PVector a) {
    acceleration.add(a);
  }
 
  
  /**
   * A bunch of methods that rotates the object
   * in the four directions, up, down, right and left 
  */
  void rotateUp() {
    boost(new PVector(step, 0));
  }
  void rotateDown() {
    boost(new PVector(-step, 0));
  }
  void rotateLeft() {
    boost(new PVector(0, -step));
  }
  void rotateRight() {
    boost(new PVector(0, step));
  }
 
 
  /**
   * Method that updates the rotation of the shape
   * depending on the acceleration it has
  */
  void update() {
    shape.rotateX(acceleration.x);
    shape.rotateY(acceleration.y);
    
    acceleration.mult(elasticity);
  }
  
}
