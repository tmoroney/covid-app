//barChart = new BarChart(0, 0, 900, 600, "", COLOR_WHITE, COLOR_RED, robotoFont, true, 0, list, 1, 10000, "Florida"); //paste for testing, 20:20 25/03/2021
// T. Moroney, Added BarChart subclass of Widget template, 1:30pm 24/03/2021
class BarChart extends Widget {
  String parent;
  int division;
  int catNum;
  float unitWidth;
  float unitHeight;
  float highest;
  ArrayList<DataLine> data;
  ArrayList<String> labels, labels2;
  ArrayList<Integer> results, results2;
  HashMap<String, Integer> areas;

  BarChart(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, int catNum, int top, String parent) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.catNum = catNum;
    this.data = data;
    this.parent = parent;
    // B. Paisley added objects to the constructor, 20:20 25/03/2021
    // B. Paisley added objects to the constructor, 11:45am 30/03/2021
    labels = new ArrayList<String>();
    labels2 = new ArrayList<String>();
    results = new ArrayList<Integer>();
    results2 = new ArrayList<Integer>();
    areas = new HashMap<String, Integer>();//B. Paisley added HashMap for analysing, 17:10 01/04/2021
    //processCat(top);
    //processResults(top);
    processMap();//B. Paisley added new method to setup, 17:10 01/04/2021
  }

  // B. Paisley updated draw method, 20:20 25/03/2021
  void draw() {
    fill(widgetColor);
    rect(x, y, width, height);
    //drawBars();
    // B. Paisley updated DrawMethod, 11:45am 30/03/2021
    //drawText();
    drawBoth();//B. Paisley added new method to draw, 17:10 01/04/2021
  }
  
  // B. Paisle added an updated and more efficent data analysing method, 17:10 01/04/2021
  void processMap(){//B. Paisley updated method to allow for finding cases of states with area numbers less than 9, 22:30 19/04/2021
    // B. Paisley updated method for refreshing, 19:00pm 03/04/2021
    if(areas!=null) areas.clear();
    if(labels!=null) labels.clear();
    if(results!=null) results.clear();
    highest = 0;
    for(DataLine entry : data){
      if(parent.equalsIgnoreCase(entry.state)){
        areas.put(entry.area, entry.cases);
      }
    }
    int currentHigh = 0;
    int pastHigh = 1999999999;
    String county = "";
    for(int i= 0; i < areas.size();i++){
      if(i>8)break;
      county = "";
      for(String c : areas.keySet()){
        int num = areas.get(c);
        if(num > currentHigh && num < pastHigh){
          currentHigh = num;
          county = c;
        }
      }
      results.add(currentHigh);
      if(!county.equals(""))labels.add(county);
      pastHigh = currentHigh;
      currentHigh = 0;
    }
    if(labels.size()>=8){
      int total = 0;
      for(String c : areas.keySet()){
        boolean add = true;
        for(String l : labels){
          if(l.equalsIgnoreCase(c)){
            add = false;
          }
        }
        if(add){
          total += areas.get(c);
        }
      }
      results.add(total);
      labels.add("Others..");
    }
    for(int cases : results){
      if(cases > highest){
        highest = cases;
      }
    }
  }
  // B. Paisley updated code to be more efficient, the following methods are for reference, 17:10 01/04/2021
  //// B.Paisley added processCat method, 20:20 25/03/2021
  //void processCat(int top) {
  //  String tempParent = "";
  //  boolean add = false;
  //  if (data != null) {
  //    String condition = "";
  //    for (DataLine entry : data) {
  //      int i = data.indexOf(entry);
  //      if (catNum == DATE_INDEX) {
  //        condition = entry.date;
  //      } else if (catNum == AREA_INDEX) {
  //        condition = entry.area;
  //        tempParent = entry.state;
  //      } else if (catNum == STATE_INDEX) {
  //        condition = entry.state;
  //        tempParent = entry.country;
  //      } else if (catNum == GEOID_INDEX) {
  //        condition = String.format("%d", entry.geoID);
  //      }
  //      if (i > 0 && top > 0) {
  //        if (labels == null && parent == tempParent) {
  //          labels.add(condition);
  //        } else {
  //          if (labels != null && parent.equalsIgnoreCase(tempParent)) {
  //            add = true;
  //          }
  //          for (String label : labels) {
  //            if (label.equalsIgnoreCase(condition) || !parent.equalsIgnoreCase(tempParent)) {
  //              add = false;
  //            }
  //          }
  //          if (add) {
  //            labels.add(condition);
  //          }
  //        }
  //        top--;
  //        if (top <= 0) {
  //          break;
  //        }
  //      }
  //    }
  //  }
  //  unitWidth = width/((2 * labels.size()) + 1);
  //}
  //// B.Paisley added processResults method, 20:20 25/03/2021
  //void processResults(int top) {
  //  String condition = "";
  //  for (String label : labels) {
  //    int total = 0;
  //    int topTemp = top;
  //  inner:
  //    for (DataLine entry : data) {
  //      topTemp--;
  //      if (topTemp<=0) {
  //        break inner;
  //      }
  //      if (catNum == DATE_INDEX) {
  //        condition = entry.date;
  //      } else if (catNum == AREA_INDEX) {
  //        condition = entry.area;
  //      } else if (catNum == STATE_INDEX) {
  //        condition = entry.state;
  //      } else if (catNum == GEOID_INDEX) {
  //        condition = String.format("%d", entry.geoID);
  //      }
  //      if (label.equalsIgnoreCase(condition)) {
  //        total = entry.cases;
  //      }
  //    }
  //    results.add(total);
  //  }
  //  for (int k : results) {
  //    results2.add(k);
  //  }
  //  int index = 0;
  //  highest = 0;
  //  for (int total : results) {
  //    if (total > highest) {
  //      highest = total;
  //      index = results.indexOf(total);
  //    }
  //  }
  //  labels2.add(labels.get(index));
  //  unitHeight = height/highest;
  //  //B. Paisley added code to find the top 9 state/counties, 11:45am 30/03/2021
  //  int currentHigh = 0;
  //  float pastHigh = highest;
  //  index = 0;
  //  for (int k = 1; k < 9; k++) {
  //    for (int v : results) {
  //      if (v < pastHigh && v > currentHigh) {
  //        currentHigh = v;
  //        index = results.indexOf(v);
  //      }
  //    }
  //    pastHigh = currentHigh;
  //    currentHigh = 0;
  //    labels2.add(labels.get(index));
  //  }
  //  java.util.Collections.sort(results);
  //}
  //// B. Paisley added draw Bars method, 20:20 25/03/2021
  //void drawBars() {
  //  int space = 0;
  //  /*
  //  for(int total : results){
  //   unitWidth = width/((2*labels.size())+1);
  //   space++;
  //   int i = results.indexOf(total);
  //   fill(colors.get(results.indexOf(total)));
  //   rect(x+(unitWidth*(i+space)), height - (unitHeight * total), unitWidth, unitHeight * total);
  //   }
  //   */
  //  // B. Paisley updated DrawBars Method, 11:45am 30/03/2021
  //  // B. Paisley added heights to the bars, 13:30pm 31/03/2021
  //  for (int i = 0; i <= 4; i++) {
  //    stroke(COLOR_DARK_GREY);
  //    strokeWeight(1);
  //    line(x, y + (i * (height / 4)), x + width, y + (i * (height / 4)));
  //    noStroke();
  //  }
  //  for (int i = 0; i < 9; i++) {
  //    unitWidth = width/21;
  //    space++;
  //    int t = results.size();
  //    // O. Mroz, Changed colors displayed to constant CHART_COLORS, 3:30pm 01/04/2021 
  //    fill(CHART_COLORS[i]);
  //    rect(x + (unitWidth * (i + space)), y + height - (unitHeight * results.get(t - (i + 1))), unitWidth, unitHeight * (results.get(t - (i + 1))));
  //  }
  //  float j = 0;
  //  for (int total : results) {
  //    int t = results.size() - results.indexOf(total);
  //    if (t < 9) {
  //      break;
  //    }
  //    j += total;
  //    if (j>highest) {
  //      j=highest;
  //    }
  //    fill(CHART_COLORS[9]);
  //    rect(x + (unitWidth * 19), y + height - (unitHeight * j), unitWidth, unitHeight * j);
  //  }
  //}
  ////B. Paisley Added DrawText method, 11:45am 30/03/2021
  //void drawText() {
  //  fill(0);
  //  textAlign(CENTER, TOP);
  //  textSize(20);
  //  text(label, x + width/2, y + 10);
  //  int space = 0;
  //  for (int i = 0; i < 9; i++) {
  //    unitWidth = width/21;
  //    space++;
  //    //int t = results.size();
  //    String s = labels2.get(i);
  //    fill(CHART_COLORS[i]);
  //    textSize(11);
  //    textAlign(CENTER, TOP);
  //    //text(s, x+unitWidth/2+(unitWidth*(i+space)), height-(unitHeight*results.get(t-(i+1))));
  //    text(s, x + unitWidth/2 + (unitWidth * (i + space)), y + height + 10);
  //  }
  //  fill(CHART_COLORS[9]);
  //  textAlign(CENTER, TOP);
  //  text("Other", x + unitWidth/2 + (unitWidth * 19), y + height + 10);
  //  // B. Paisley added measurements to the bars, 13:30pm 31/03/2021
  //  for (int i = 0; i <= 4; i++) {
  //    fill(0);
  //    textAlign(LEFT, CENTER);
  //    text(String.format("%.0f", i*(highest/4)), x+width+4, y + height - (i * (height/4)) - 3);
  //  }
  //}
  
  // B. Paisley added more effiecient and cleaner darw method, 17:10 01/04/2021
  void drawBoth(){//B. Paisly added fixes for array index bugs, 22:30 19/04/2021
    unitWidth = width / (2*(labels.size())+1); //<>//
    unitHeight = height / highest;
    int space = 0;
    for (int i = 0; i <= 4; i++) {
      stroke(COLOR_DARK_GREY);
      strokeWeight(1);
      line(x, y + (i * (height / 4)), x + width, y + (i * (height / 4)));
      noStroke();
    }
    for(String c : labels){
      space++;
      int i = labels.indexOf(c);
      fill(CHART_COLORS[i]);
      rect(x+(unitWidth * (i+space)),y+height-(unitHeight*results.get(i)),unitWidth,unitHeight*results.get(i));
    }
    space = 0;
    String area = "";
    for(String c : labels){
      space++;
      int i = labels.indexOf(c);
      fill(CHART_COLORS[i]);
      pushMatrix();
      translate(x + (unitWidth * (i + space)), y + height + 10);
      textSize(11);
      textAlign(LEFT, CENTER);
      rotate(radians(12));
      area = (c.equalsIgnoreCase("Unknown")) ? "N/A" : c;//B .Paisley added QoL change t0 BarChart, 14:32 10/04/21
      text(area, 0,0);
      popMatrix();
    }
    for (int i = 0; i <= 4; i++) {
      fill(0);
      textAlign(LEFT, CENTER);
      text(formatter.format(i*(highest/4)), x+width+4, y + height - (i * (height/4)) - 3); // S. Cataluna replaced string format with decimal format to make labels easier to read 9:40pm 12/04/2021
    }
    // O. Mroz, Added top label text, 3:30pm 19/04/2021
    fill(labelColor);
    textAlign(CENTER, TOP);
    textSize(22);
    text(label, x + width/2, y + 10);
  }
}
