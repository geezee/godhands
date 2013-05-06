/**
 *  Anaglyph class that creates anaglyph images
*/
class Anaglyph {
  
  // The two images representing the left
  // and right eye
  private PImage left, right;
  
  
  /**
   *  Anaglyph constructor
   *
   *  @param l      The left image
   *  @param r      The right image
  */
  Anaglyph(PImage l, PImage r) {
    left = l;
    right = r;
  }
  
  
  /**
   * Updates the left image
   * @param l      The new left image
  */
  void updateLeft(PImage l) {
    left = l;
  }
  /**
   * Updates the right image
   * @param r      The new right image
  */
  void updateRight(PImage r) {
    right = r;
  }
  
  /**
   * Gets the right image
   * @return      The right Image (PImage)
  */
  PImage getRight() {return right;}
  /**
   * Gets the left image
   * @return      The left Image (PImage)
  */
  PImage getLeft() {return left;} 
  
  /**
   * Renders the anaglyph version
   * @return      The anaglyph image (PImage)
  */
  PImage render() {
    // Create the anaglyph image to render
    PImage anaglyph = createImage(left.width,left.height,RGB);
    
    // convert left and right images to grayscale
    // left = createBW(left);
    // right = createBW(right);
    
    // Load all the pixels
    anaglyph.loadPixels();
    left.loadPixels();
    right.loadPixels();
    

    // Create the anaglyph image from the left cyan and red right
    for(int i=0;i<right.pixels.length;i++) {
      int r = int(red(left.pixels[i])*0.21 + green(left.pixels[i])*0.71
                  + blue(left.pixels[i])*0.07);
      int c = int(red(right.pixels[i])*0.21 + green(right.pixels[i])*0.71
                  + blue(right.pixels[i])*0.07);
      anaglyph.pixels[i] = color(r,c,c);
    }
    
    anaglyph.updatePixels();
    return anaglyph;
  }
  
  
  /**
   * Applies the luminosity algorithm to the image provided
   * 0.21 R + 0.71 G + 0.07 B
   * @return      The black and white version of the image
  */
  PImage createBW(PImage img) {
    // The black and white version image to return
    PImage bw = createImage(img.width, img.height, RGB);
    
    // Load the pixels
    img.loadPixels();
    bw.loadPixels();
    
    for(int i=0;i<img.pixels.length;i++) {
      bw.pixels[i] = color(int(red(img.pixels[i])*.21 +
                     blue(img.pixels[i])*.07 +
                     green(img.pixels[i])*.71));
    }
    
    bw.updatePixels();
    return bw;
  }

}
