// O. Mroz, Added Widget Class from previous assignment, 3:30pm 22/03/2021
class Widget {
  String id;
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  boolean hoverEffect;
  boolean borderShown;
  float boxRadius;
  int verticalAlign;
  int horizontalAlign;
  int fontSize;
  boolean cursor = false;

  Widget(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event; 
    this.widgetColor=widgetColor;
    this.widgetFont=widgetFont;
    this.labelColor= labelColor;
    this.borderShown = borderShown;

    this.fontSize = 20;
    this.horizontalAlign = CENTER;
    this.verticalAlign = CENTER;
    this.boxRadius = height/5;
    this.hoverEffect = true;
  }

  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y && mY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }

  void draw() {
    if (borderShown) {
      strokeWeight(2);
      if (hoverEffect && mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) stroke(40, 40, 40, 200);
      else stroke(40);
    } else noStroke();

    if (hoverEffect && mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      fill(widgetColor, 200);
      cursor = true;
    } else fill(widgetColor);
    rect(x, y, width, height, boxRadius);
    noStroke();
    if (hoverEffect && mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) fill(labelColor, 200);
    else fill(labelColor);
    textFont(widgetFont);
    textSize(fontSize);
    textAlign(verticalAlign, horizontalAlign);
    float textPosX = width/2;
    if (verticalAlign == LEFT) textPosX=0;
    else if (verticalAlign == RIGHT) textPosX=width;
    int textPosY = height/2;
    if (verticalAlign == TOP) textPosY=0;
    else if (verticalAlign == BOTTOM) textPosY=height;
    text(label, x + textPosX, y + textPosY - 3); 
    //S.Cataluna added if statements for mouse cursor effects when hovering
    if (hoverEffect && cursor && mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      cursor(HAND);
    }
    if (cursor && (mouseX < x || mouseX > x+width || mouseY < y || mouseY > y+height)) {
      cursor  = false;
      cursor(ARROW);
    }
  }

  void setColor(color widgetColor) {
    this.widgetColor = widgetColor;
  }

  void setID(String id) {
    this.id = id;
  }

  void setHoverEffect(boolean hoverEffect) {
    this.hoverEffect = hoverEffect;
  }

  void setLabel(String label) {
    this.label = label;
  }

  void showBorder(boolean borderShown) {
    this.borderShown = borderShown;
  }
  // O. Mroz, added setBoxRadius while editing results heading, 3:30pm 01/04/2021 
  void setBoxRadius(float boxRadius) {
    this.boxRadius = boxRadius;
  }
  // O. Mroz, added align while editing results heading, 3:30pm 01/04/2021 
  void align(int vertical, int horizontal) {
    verticalAlign = vertical;
    horizontalAlign = horizontal;
  }
  // O. Mroz, added setFontSize while editing results heading, 3:30pm 01/04/2021 
  void setFontSize(int fontSize) {
    this.fontSize = fontSize;
  }
  // O. Mroz added setFontColor to change the font color of map states - 1:25AM, 08/04/2021
  void setFontColor(color labelColor) {
    this.labelColor = labelColor;
  }
}
