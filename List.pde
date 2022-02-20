// T. Moroney, Added List subclass of Widget template, 1:50pm 24/03/2021
class List extends Widget {
  int[] data;
  int[] labels;

  List(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, int[] data) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.data = data;
  }

  void draw() {
  }

}
