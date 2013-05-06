import processing.video.*;
import javax.swing.*;
import java.io.*;
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context

OBJ j;
PGraphics left, right;
Anaglyph a = new Anaglyph(left, right); // the anaglyph object
Capture camera; // the webcam
SimpleMotionDetection md; // the motion detection object
PImage prev; // the previous frame


boolean play; // state of sound

// the bars that change the parameters
ScrollBar scaleBar;
ScrollBar tresholdBar;
ScrollBar blockSizeBar;
ScrollBar depthBar;

float scale;

// File Chooser
JFileChooser fc = new JFileChooser();
int fcValue = fc.showOpenDialog(this);



void setup() {
  size(600, 620, P3D);

  if(fcValue == JFileChooser.APPROVE_OPTION) {
    File f = fc.getSelectedFile();
    j = new OBJ(f.getPath());
  } else {
    System.exit(-1); // exit if the user didn't provide a file
  }
  
<<<<<<< HEAD
 
=======
  //allow the user to play music while using the application
   String name=""; 
   if(fcValue_2 == JFileChooser.APPROVE_OPTION) {
    File f = fc_2.getSelectedFile();
     name= f.getPath();
     minim = new Minim(this);
     player = minim.loadFile(name, 2048);
     player.play();
     println("Playing");
  }
>>>>>>> ebee6843139a3b152a9103b2cca3aded74ba0a19
  

  left = createGraphics(600,500,P3D);
  right = createGraphics(600,500,P3D);

  scaleBar = new ScrollBar(250, 580, "Scale", 100, 100);
  scaleBar.setValue(0.7);
  tresholdBar = new ScrollBar(250, 560, "Sensitivity", 256, 100);
  tresholdBar.setValue(50);
  blockSizeBar = new ScrollBar(250, 540, "Block Size", 50, 100);
  blockSizeBar.setValue(8);
  depthBar = new ScrollBar(250, 520, "Depth", 50, 100);
  depthBar.setValue(10);

  camera = new Capture(this, 320, 240, 30);
  camera.start();
  md = new SimpleMotionDetection(50);
  prev = createImage(camera.width, camera.height, RGB);

  frameRate(27);
}

/**
 * Draws the frame
*/
void draw() {
  // Fill the viewport with a black background
  fill(color(0));
  noStroke();
  rect(0,0,600,620);

  left.beginDraw();
  left.background(0);
  left.noStroke();
  
  // create the light
  left.directionalLight(120, 120, 120, 0, 0, -1);
  left.ambientLight(120, 120, 120);
  
  // setup the geometry of the scene
  left.translate(width/2, height/2);
  
  
  // draw the shape
  left.scale(scale);
  left.shape(j.getShape(),depthBar.getValue()/(2*scale),0);
  left.endDraw();
  
  right.beginDraw();
  right.background(0);
  right.noStroke();
  right.directionalLight(120, 120, 120, 0, 0, -1);
  right.ambientLight(120, 120, 120);
  
  // setup the geometry of the scene
  right.translate(width/2, height/2);
  right.scale(scale);
  right.shape(j.getShape(),-depthBar.getValue()/(2*scale),0);
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
  image(camera, 440, 500, 160, 120);
  image(diff, 0, 500, 160, 120);
  PVector loc = md.getMotionLocation(diff);
  noStroke();
  fill(color(255, 0, 0));
  ellipse(440+loc.x/2, 500+loc.y/2, 5, 5);


  // Display the bars and change the parameters
  depthBar.show();

  scaleBar.show();
  scale = scaleBar.getValue();

  tresholdBar.show();
  md.setTreshold((int) tresholdBar.getValue());

  blockSizeBar.show();
  md.setBlockSize((int) blockSizeBar.getValue());
  
  buttons();
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

void buttons(){
  stroke(200);
  fill(125);
  rect(width-100,0,100,30);
  fill(0);
  text("Change Model",width-90,20);
  fill(125);
  rect(0,0,80,30);
  rect(82,0,30,30);
  fill(200);
  if(play){
    rect(90,5,5,20);
    rect(100,5,5,20);
  }
  else {
    beginShape();
      vertex(90,5);
      vertex(105,15);
      vertex(90,25);
    endShape();
  }
  fill(0);
  text("Play Music",10,20);
}

void mousePressed(){
  //allow the user to change the model
  if(mouseX>width-100 && mouseX<width && mouseY >0 && mouseY <30){
      fc = new JFileChooser();
      fcValue = fc.showOpenDialog(this);
      if(fcValue == JFileChooser.APPROVE_OPTION) {
          File f = fc.getSelectedFile();
          j = new OBJ(f.getPath());
    }
  }
  else if( mouseX>0 && mouseX<80 && mouseY >0 && mouseY <30){
      JFileChooser fc_2 = new JFileChooser();
      int fcValue_2 = fc_2.showOpenDialog(this);
       //allow the user to play music while using the application
       String name=""; 
       if(fcValue_2 == JFileChooser.APPROVE_OPTION) {
           File f = fc_2.getSelectedFile();
           name= f.getPath();
           minim = new Minim(this);
           player = minim.loadFile(name, 2048);
           player.play();
           play=true;
        }
  }
  
  //pause or play current music file
  else if(minim!=null && mouseX>82 && mouseX<112 && mouseY >0 && mouseY <30){
    if(play){
      player.pause();
      play=false;
    }
    else {
      player.play();
      play=true;
    }
  }
}
