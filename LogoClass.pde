class LogoClass extends Widget {
  PImage covidImg;
  int x;
  int y;
  
  LogoClass(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, PImage covidImage) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.x = x;
    this.y = y;
    covidImg = covidImage;
  }
  
  void draw() {
    image(covidImg, x, y, width, height);
  }
}
