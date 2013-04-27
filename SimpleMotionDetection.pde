class SimpleMotionDetection {
  
  private PImage previous;
  private PImage current;
  private int treshold;

  SimpleMotionDetection(int treshold) {
    this.treshold = treshold;
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

}
