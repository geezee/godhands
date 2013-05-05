/**
 * A scrollbar class that handles scrollbar
 * used to change parameters
*/
class ScrollBar {
    
    private String label; // the label
    private float upperRange; // the maximum value
    private int width; // the width of the bar
    private float value; // the value

    private int x, y; // location
    private int dotX;

    /**
     * Constructor
     *
     * @param x         x location
     * @param y         y location
     * @param label     the label used
     * @param ur        the upper range (maximum value)
     * @param w         the width of the bar
    */
    ScrollBar(int x, int y, String label, float ur, int w) {
        this.label = label;
        upperRange = ur;
        width = w;

        this.x = x;
        this.y = y;
    }


    String getLabel() {
        return label;
    }
    void setLabel(String s) {
        label = s;
    }
    float getValue() {
        return value;
    }
    void setValue(float r) {
        value = r;
    }


    /**
     * Draw the scrollbar
    */
    void show() {
        noStroke();
        fill(color(255));

        text(label, x-80, y+5);
        rect(x,y,width,2,10);

        stroke(color(10,10,230));
        fill(color(50,50,200));

        dotX = x+int((value/upperRange)*width);
        ellipse(dotX, y+1, 10, 10);

        if(mousePressed &&
           mouseY >= y-5 && mouseY <= y+5 &&
           mouseX >= x && mouseX <= x+width) {
               value = upperRange*(mouseX-x)/width;
        }

        fill(color(255));
        text(value,x+width+10,y+5);
    }

}
