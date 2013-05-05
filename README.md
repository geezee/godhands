GODHANDS
========

Description
-----------
An application that lets you interact with 3D objects in space!
Originally a final year project for the Digital Media Programming course (CMPS230) at the [American University of Beirut](http://aub.edu.lb) advised by [Dr. Maha El Choubassi](http://choubassi.com)

You load an object (.obj) file, you turn on your camera, and move around, the object will react according to your movements.

License
-------
Copyright (C) 2013 [George Zakhour][3] and [Remi Nassar][2]

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

Dependecies
-----------
For Debian user, processing (to connect to the camera depends on the following packages)

- `libgstreamer-plugins-base0.10-dev`
- `libgstfarsight0.10-dev`
- `libgstreamer0.10-dev`


Documentation
-------------
The documentation of this program is provided as follow: we will list all the libraries that were used. Foreach library there is a brief description of it, a list of all the methods that are accessible to the user along a brief description of the parameters, the return and the goal of it. As well, a brief example is used to illustrate how to use this class.

The projects includes the following:

* [**Anaglyph Library**](#anaglyph)
* [**OBJ Library**](#obj)
* [**SimpleMotionDetection**](#motion)
* [**ScrollBar**](#scroll)

###Anaglyph Library<a id="anaglyph"></a>
The library consists of a class `Anaglyph` that creates anaglyph images provided two `PImage`s 

The public methods in that class are:

- `Anaglyph(PImage, PImage)` (Constructor) sets the object
- `updateLeft(PImage)` updates the left-eye image
- `updateRight(PImage)` updates the right-eye image
- `getRight()` returns the right-eye image
- `getLeft()` returns the left-eye image
- `render()` creates the anaglyph version of the two images and returns it
- `createBW(PImage)` applies the Luminance grayscale algorithm on the image supplied and returns the grayscale version

```
PImage left = loadImage("left.jpg");
PImage right = loadImage("right.jpg");
Anaglyph g = new Anaglyph(left,right);

void setup() {
    size(left.width, left.height);
    noLoop();
}
void draw() {
    image(g.render(),0,0);
}
```

###OBJ Library<a id="obj"></a>
The library consists of a class `OBJ` that is a wrapper class to `PShape` provided by [processing][4]. As well it adds to it the ability to boost the object giving a certain acceleration.

The public methods in that class are:

- `OBJ(String)` (Constructor) will load that shape to the PShape
- `getShape()` returns the shape
- `boost(PVector)` will add acceleration to the object
- `rotateUp()` will rotate the object up
- `rotateDown()` will rotate the object down
- `rotateLeft()` will rotate the object left
- `rotateRight()` will rotate the object right
- `update()` will update the rotation of the cube depending on the acceleration of the object

```
OBJ o;

void setup() {
    o = new OBJ("/path/to/model.obj"); // load the 3D model
    size(300, 300, P3D); // to make it 3D
}

void draw() {
    background(0);
    noStroke();
    directionalLight(120, 120, 120, 0, 0, -1);
    ambientLight(120, 120, 120);
    translate(width/2, height/2);
    scale(80);
    shape(j.getShape(),0,0);
}
```

###Simple Motion Detection<a id="motion"></a>
The library consists of a class `SimpleMotionDetection` that handles in a very minimalistic and simple
way motion detection in 2 images given. The library, given the old frame and current one, checks
pixel by pixel where the colors are not equal within a range, if they are not equal then motion happens.

The public methods in that class are:

- `SimpleMotionDetection(int)` (Constructor) will create the engine, int is how strict the engine should be: 0 very strict, 255 least strict.
- `setPrevious(PImage)` sets the previous variable, that is the last frame to compare with the current one
- `setCurrent(PImage)` sets the current variable, the way that will be compared the previous frame
- `setTreshold(int)` change the strictness of the engine
- `getPrevious()` returns the previous image (PImage)
- `getCurrent()` returns the current image (PImage)
- `getTreshold()` returns the strictness of the engine (int)
- `getDiff()` returns the dithered image that represents in black pixels where the motion happened
- `getMotionLocation()` returns the location of the motion. The image checks the location of all the motion pixels and then gets the average location between them
- `getOverallMotionVector()` returns the motion vector of the motion that occured

```
import processing.video.*;
Capture camera;
SimpleMotionDetection md;
PImage prev;

void setup() {
        camera = new Capture(this, 320, 240, 30);
        camera.start();
        md = new SimpleMotionDetection(50);
        prev = createImage(camera.width, camera.height, RGB);
        size(640, 240);
}

void draw() {
        if(camera.available()) {
                prev = createImage(camera.width, camera.height, RGB);
                prev.copy(camera, 0, 0, camera.width, camera.height, 0, 0,
                          camera.width, camera.height);
                prev.updatePixels();
                camera.read();
        }
        md.setPrevious(prev);
        md.setCurrent(camera);

        image(md.getDiff(), 0, 0);
        image(camera, 320, 0);

        PVector loc = md.getMotionLocation();
        noStroke();
        fill(color(255, 0, 0));
        ellipse(320+loc.x, loc.y);
}
```

###Scrollbar<a id="scroll"></a>
The library consists of a class called `ScrollBar` that handles minimalistic scroll bars. Given the label
the width, the maximum value and the position the library will draw a bar where the user can select values
from.

The public methods in the class are:

- `ScrollBar(int,int,String,float,int)` (Constructor) takes the x position, y position, the label of the bar, the maximum value and the width of the bar
- `getLabel()` returns the label used
- `getValue()` returns the current value that the bar represents
- `setLabel(String)` changes the label to a given one
- `setValue(float)` changes the value to a new one
- `show()` displays the bar


```
ScrollBar sensitivity;

void setup() {
    sensitivity = new ScrollBar(10, 10, "Sensitivity", 10, 100);
    sensitivity.setValue(3); // default value

    size(200, 400);
}

void draw() {
    sensitivity.show();
    println("Current sensitivity is: "+sensitivity.getValue());
}

```


Contributors
------------
- [George Zakhour][3] [gez00@aub.edu.lb][1]
- Remi Nassar [rmn30@aub.edu.lb][2]


Credits
-------
- The `SimpleMotionDetection` class was inspired from Daniel Shiffman's [Chapter 16: Example 16-23: Simple Motion Detection](http://www.learningprocessing.com/examples/chapter-16/example-16-13/)




[1]: mailto:gez00@aub.edu.lb    "George Zakhour"
[2]: mailto:rmn30@aub.edu.lb    "Remi Nassar"
[3]: http://george.zakhour.me   "George Zakhour"
[4]: http://processing.org      "Processing"
