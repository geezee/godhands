class SimpleMotionDetection {
  
  private PImage previous;
  private PImage current;
  private int treshold;
  private ArrayList points;
  private PVector old;

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


  PVector getMotionLocation() {
    PVector all = new PVector(0,0);
    for(int i=0;i<points.size();i++)
      all.add((PVector) points.get(i));
    all.div(points.size());
    all.add(old);
    all.div(2);
    return all;
  }

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
