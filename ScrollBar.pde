// B. Paisley added a Scrollbar Subclass for Rankings, 20:00 08/04/2021
public class ScrollBar extends Widget{
  float maxHeight;
  float minHeight;
  float barX;
  float barY, newY, loose;
  float restHeight;
  boolean locked, over;
  // B. Paisley updated Scrollbar to be more effective, 21:53 08/04/2021
  ScrollBar(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, int bottom){
    super(x,y,width,height,label,widgetColor,labelColor,widgetFont,borderShown,event);
    restHeight = bottom - y;
    barX = x;
    barY = y;
    newY = y;
    minHeight = barY + 20;
    maxHeight = barY + restHeight - 20;
    loose = 1;
  }
  void update(){
    if(overEvent()){
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over){
      locked = true;
    }
    if (!mousePressed){
      locked = false;
    }
    if (locked){
      newY = constrain(mouseY-width/2, minHeight, maxHeight);
    }
    if (abs(newY - y) > 1){
      super.y = int(y + (newY-y)/loose);
    }
  }
  float constrain(float val, float minHeight, float maxHeight){
    return min(max(val, minHeight), maxHeight);
  }
  boolean overEvent(){
    if(mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height){
      return true;
    } else {
      return false;
    }
  }
  void display(){
    // O. Mroz, Edited colors and slightly edited dimensions, 3:00pm 16/04/2021 
    noStroke();
    fill(COLOR_FREESIA);
    stroke(COLOR_DARKER_GREY);
    strokeWeight(2);
    rect(barX, barY, width, restHeight, 3);
    stroke(COLOR_DARKER_GREY);
    line(x + 4, barY + 13, x + width / 2, barY + 5);
    line(x + width / 2, barY + 5, x + width - 4, barY + 13);
    line(x + 4, barY + restHeight - 13, x + width / 2, barY + restHeight - 5);
    line(x + width / 2, barY + restHeight - 5, x + width - 4, barY + restHeight - 13);
    noStroke();
    if (over || locked){
      fill(COLOR_SALMON);
    } else { 
      fill(COLOR_AQUAMARINE);
    }
    if(y-barY<=0){
      y+=20;
    }
    if(y + height>=maxHeight){
      y = int(maxHeight - height);
    }
    stroke(COLOR_DARKER_GREY);
    strokeWeight(2);
    rect(x+1,y,width-2,height, 3);
    noStroke();
    // O. Mroz, Added cursor hover effects, 3:00pm 16/04/2021 
    if (mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      cursor(HAND);
      cursor = true;
    }
    if (cursor && (mouseX < x || mouseX > x+width || mouseY < y || mouseY > y+height)) {
      cursor  = false;
      cursor(ARROW);
    }
  }
  void draw(){
    check();
    update();
    display();
  }
  void tmove(int event){
    if(event < 0) {
      y++;
    } else if(event > 0){
      y--;
    }
  }
  void check(){
    if (y >= maxHeight - height) {
      y = int(maxHeight - height);
    }
    if (y <= minHeight) {
      y = int(minHeight); //<>//
    }
  }
  float getScroll(){ //B. Paisley added methed to find the percantage of the bar, 19:47 10/04/21
    float pos = ((y - minHeight)/((maxHeight-height)-minHeight)); //<>//
    return pos;
  }
}
