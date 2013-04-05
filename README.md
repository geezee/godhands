GODHANDS
========

Description
-----------
An application that lets you interact with 3D objects in space! 

You load an object (.obj) file, you turn on your camera, and move around, the object will react according to your movements (rotate, scale, move...)

License
-------
Copyright (C) 2013 [George Zakhour][3] and [Remi Nassar][2]

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

Documentation
-------------
The documentation of this program is provided as follow: we will list all the libraries that were used. Foreach library there is a brief description of it, a list of all the methods that are accessible to the user along a brief description of the parameters, the return and the goal of it. As well, a brief example is used to illustrate how to use this class.

The projects includes the following:

* [**Anaglyph Library**](#anaglyph)
* [**OBJ Library**](#obj)

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

Contributors
------------
- [George Zakhour][3] [gez00@aub.edu.lb][1]
- Remi Nassar [rmn30@aub.edu.lb][2]

[1]: mailto:gez00@aub.edu.lb    "George Zakhour"
[2]: mailto:rmn30@aub.edu.lb    "Remi Nassar"
[3]: http://george.zakhour.me   "George Zakhour"
[4]: http://processing.org      "Processing"
