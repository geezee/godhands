/**
  Simple Motion Detection is a class
  that will handle basic motion detection in
  two images given

  Inspired from Daniel Shiffman's "Chapter 16: Example 16-23: Simple Motion Detection"
  <http://www.learningprocessing.com/examples/chapter-16/example-16-13/>
*/
class SimpleMotionDetection {
  
  private PImage previous; // the prvious frame
  private PImage current; // the current frame
  private int treshold; // strictness
  private ArrayList points; // where the motion pixels are
  private PVector old; // the old motion vector


  /**
    * Constructor
    *
    * @param int        how strict should it be
  */
  SimpleMotionDetection(int treshold) {
    this.treshold = treshold;
    points = new ArrayList();
    old = new PVector(0, 0);
  }


  void setPrevious(PImage p) {
    previous = p;
  }
  void setCurrent(PImage c) {
    current = c;
  }
  void setTreshold(int t) {
    treshold = t;
  }


  PImage getPrevious() {
    return previous;
  }
  PImage getCurrent() {
    return current;
  }
  int getTreshold() {
    return treshold;
  }
  

  // Creates a dithered image representing the motion
  // in the image
  PImage getDiff() {
    PImage diff = createImage(previous.width, previous.height, RGB);
    diff.loadPixels();
    current.loadPixels();
    previous.loadPixels();
    points = new ArrayList();

    for(int i=0;i<diff.pixels.length;i++) {
      color c = current.pixels[i];
      color p = previous.pixels[i];
      float cr = red(c)+green(c)+blue(c);
      float pr = red(p)+green(p)+blue(p);

      if(abs(cr-pr) < treshold*3) diff.pixels[i] = color(255);
      else {
        diff.pixels[i] = color(0);
        points.add(new PVector(i%diff.width, i/diff.width));
      }
    }
    diff.updatePixels();

    return diff;
  }


  // Get the motion location, where the motion
  // is in the picture
  PVector getMotionLocation() {
    PVector all = new PVector(0,0);
    for(int i=0;i<points.size();i++)
      all.add((PVector) points.get(i));
    all.div(points.size());
    all.add(old);
    all.div(2);
    return all;
  }

  // gets the overall motion vector
  PVector getOverallMotionVector() {
    PVector motion = getMotionLocation();
    if(!Float.isNaN(motion.x)) {
      old.sub(motion);
      PVector tmp = old;
      old = motion;
      return tmp;
    } else return new PVector(0, 0);
  }

}
