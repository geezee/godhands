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
  private PVector old; // the old motion vector
  private int scanBlock; // what is the block size when scanning


  /**
    * Constructor
    *
    * @param int        how strict should it be
  */
  SimpleMotionDetection(int treshold) {
    this.treshold = treshold;
    old = new PVector(0, 0);
    scanBlock = 8;
  }

  
  /**
    * Setters for the previous/current and treshold
    * variable
  */
  void setPrevious(PImage p) {
    previous = p;
  }
  void setCurrent(PImage c) {
    current = c;
  }
  void setTreshold(int t) {
    treshold = t;
  }
  void setBlockSize(int s) {
      scanBlock = s;
  }


  /**
    * Getters for the previous/current and treshold
    * variable
  */
  PImage getPrevious() {
    return previous;
  }
  PImage getCurrent() {
    return current;
  }
  int getTreshold() {
    return treshold;
  }
  int getBlockSize() {
      return scanBlock;
  }

  


  /**
    * Method that creates a new PImage that represents the motion
    * happening in both frames
    *
    * @return PImage        the image that shows the motion
  */
  PImage getDiff() {
    PImage diff = createImage(previous.width, previous.height, RGB);
    diff.loadPixels();
    current.loadPixels();
    previous.loadPixels();
    for(int i=0;i<diff.pixels.length;i++) {
      color c = current.pixels[i];
      color p = previous.pixels[i];
      float cr = red(c)+green(c)+blue(c);
      float pr = red(p)+green(p)+blue(p);

      if(abs(cr-pr) < treshold*3) diff.pixels[i] = color(255);
      else diff.pixels[i] = color(0);
    }
    diff.updatePixels();

    return diff;
  }




  /**
    * Method that finds the location of the major
    * motion in the self-generated diff image
    *
    * @return PVector       the location of the motion
  */
  PVector getMotionLocation() {
    return getMotionLocation(getDiff());
  }


  /**
    * Method that finds the location of the major
    * motion in the given diff image
    *
    * The algorithm deployed is as follow:
    * we start by scanning blocks in the diff image
    * then for the blocks that contain 80% black
    * dots we add them to a list that holds
    * the potential locations of the motion
    * when finishing it finds the average of these
    * locations
    *
    * @param PImage         the diff image
    * @return PVector       the location of the motion
  */
  PVector getMotionLocation(PImage diff) {
    ArrayList locations = new ArrayList();

    for(int x=0;x<diff.width;x+=scanBlock) {
      for(int y=0;y<diff.height;y+=scanBlock) {
        int n = 0;
        for(int i=0;i<scanBlock;i++) {
          for(int j=0;j<scanBlock;j++) {
            n += 1-int(red(diff.get(x+i, y+j))/255);
          }
        }
        if(n >= scanBlock*scanBlock*0.8) {
            locations.add(new PVector(x, y));
        }
      }
    }


    PVector location = new PVector(0, 0);
    for(int i=0;i<locations.size();i++)
        location.add((PVector) locations.get(i));
    location.div(locations.size());

    if(location.x == 0 && location.y == 0)
        return old;
    return location;
  }




  /**
    * Method that finds out the motion vector
    *
    * @return PVector       the overall motion detection
  */
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
