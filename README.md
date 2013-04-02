GODHANDS
========
Description
-----------
An application that lets you interact with 3D objects in space! 

You load an object (.obj) file, you turn on your camera, and move around, the object will react according to your movements (rotate, scale, move...)

Documentation
-------------
The projects inclcudes the following:

* ####[Anaglyph Library](#anaglyph)

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

Contributors
------------
- [George Zakhour][3] [gez00@aub.edu.lb][1]
- Remi Nassar [rmn30@aub.edu.lb][2]

[1]: mailto:gez00@aub.edu.lb    "George Zakhour"
[2]: mailto:rmn30@aub.edu.lb    "Remi Nassar"
[3]: http://george.zakhour.me   "George Zakhour"
