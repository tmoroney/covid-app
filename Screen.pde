// O. Mroz, Added Screen Class from previous assignment, 3:30pm 22/03/2021
class Screen {
  ArrayList<Widget> widgetList;
  color backgroundColor;

  Screen() {
    widgetList = new ArrayList<Widget>();
    backgroundColor = COLOR_WHITE; // default color
  }

  void draw() {
    background(backgroundColor);
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw();
    }
  }

  void addWidget(Widget widget) {
    widgetList.add(widget);
  }

  void setBackgroundColor(color backgroundColor) {
    this.backgroundColor = backgroundColor;
  }
}
