// T. Moroney, Added Gauge subclass of Widget template, 1:40pm 24/03/2021
// T. Moroney, Added equation to convert number of cases to a rotation value, 5:30pm 25/03/2021
// T. Moroney, Added general green, yellow and red gauge using arcs, and an arrow in the middle, 1:00am 30/03/2021 
// T. Moroney, Added turning mechanism to arrow pointer in the middle of the gauge and improved formula for converting cases into radians, 10:00pm 30/03/2021
// T. Moroney, Added ability to get case numbers from the most recent date and find the max and min values for the gauge, 4:30pm 06/04/2021
// T. Moroney, Added HashMap to store the latest cases for every state and subtract the previous day, 6:20pm 07/04/2021

class Gauge extends Widget {
  PFont widgetFont;
  ArrayList<DataLine> data;
  ArrayList<Date> dateList;
  String searchResult = "";
  HashMap<String, Integer> areas;
  String[] renderAreas;
  Integer[] renderCases;
  String latestDate;
  String previousDate;
  int cases;
  int min;
  int max;
  float rotateAmount;
  float degree;
  float rotate;

  Gauge(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, ArrayList<Date> dateList, String searchResult) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.widgetFont = widgetFont;
    this.data = data;
    this.searchResult = searchResult;
    this.dateList = dateList;
    latestDate = dateList.get(dateList.size()-1).currentDate;
    previousDate = dateList.get(dateList.size()-2).currentDate;
    // T. Moroney, Added HashMap to store the latest cases for every state and subtract the previous day, 6:20pm 07/04/2021
    areas = new HashMap<String, Integer>();
    if (data != null) {
      for (int i = 0; i < data.size(); i++) {
        if (data.get(i).date.equalsIgnoreCase(previousDate)) {
          try {
            if (!this.areas.containsKey(data.get(i).state)) {
              this.areas.put(data.get(i).state, -data.get(i).cases);
            } else {
              int previousCases = this.areas.get(data.get(i).state);
              this.areas.put(data.get(i).state, previousCases - data.get(i).cases);
            }
          }
          catch (Exception ex) {
            println(ex.getMessage());
          }
        }
        else if (data.get(i).date.equalsIgnoreCase(latestDate)) {
          try {
            if (!this.areas.containsKey(data.get(i).state)) {
              this.areas.put(data.get(i).state, data.get(i).cases);
            } else {
              int previousCases = this.areas.get(data.get(i).state);
              this.areas.put(data.get(i).state, previousCases + data.get(i).cases);
            }
          }
          catch (Exception ex) {
            println(ex.getMessage());
          }
        }
      }
    }
    refreshData();
  }
  
  void resetChart(){
    degree = 0;
    rotateAmount = 0;
    rotate = 0;
    cases = 0;
    min = 1000000;
    max = 0;
  }
  
  void refreshData() {
    resetChart();
    String[] myStates = areas.keySet().toArray(new String[areas.size()]);
    Integer[] myCases = areas.values().toArray(new Integer[areas.size()]);
    for (int i=0; i<myCases.length; i++) {
      if (myStates[i].equalsIgnoreCase(searchResult)) {
        cases = myCases[i];
      }
      if (myCases[i] < min) min = myCases[i];
      if (myCases[i] > max) max = myCases[i];
    }
    min = Math.round(min/10.0) * 10;
    max = Math.round(max/100.0) * 100;
    degree = (PI+PI/3)/(max-min);
    rotateAmount = cases*degree;
  }
  
  void draw() {
    fill(112,128,144);
    stroke(0,0,0);
    strokeWeight(4);
    ellipse(x, y, width+90, height+90);
    fill(255,255,255);
    stroke(0,0,0);
    strokeWeight(4);
    ellipse(x, y, width+30, height+30);
    stroke(0,0,0);
    strokeWeight(5);
    fill(0,128,0,170);
    arc(x, y, width, height, PI-(PI/6), PI+THIRD_PI, PIE);
    fill(255,255,0,170);
    arc(x, y, width, height, PI+THIRD_PI, PI+(2*THIRD_PI), PIE);
    fill(255,0,0,170);
    arc(x, y, width, height, PI+(2*THIRD_PI), (2*PI)+(PI/6), PIE);
    fill(0,0,0);
    stroke(0,0,0);
    strokeWeight(8);
    drawArrow(x, y, height/2-height/8);
    if (rotate < rotateAmount) {
      rotate = rotate + (PI+PI/3)/150;
      if ((rotateAmount - rotate) < (PI+PI/3)/150) rotate = rotateAmount;
    }
    fill(112,128,144);
    stroke(0,0,0);
    strokeWeight(6);
    ellipse(x, y, width/10, height/10);
    textFont(widgetFont);
    textSize(15);
    fill(0,0,0);
    text("Max", x+50, y+50);
    text("Min", x-50, y+50);
    textSize(20);
    String title = "Compared To\r\nOther States";
    textLeading(26);
    text(title, x-width-width/6, y-height/2-20);
    String gaugeDate = "Latest date:\r\n";
    fill(0,0,0);
    text(gaugeDate+latestDate, x+width+width/5, y);
  }
  
  void drawArrow(int cx, int cy, int len){
    pushMatrix();
    translate(cx, cy);
    rotate(PI-PI/6+rotate);
    line(0,0,len, 0);
    line(len, 0, len - 8, -8);
    line(len, 0, len - 8, 8);
    popMatrix();
  }
  
  void setState(String newState){
    searchResult = newState;
  }
    
 
}
