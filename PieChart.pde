// T. Moroney, Added PieChart subclass of Widget template, 1:00pm 24/03/2021
class PieChart extends Widget {
  int diameter;
  ArrayList<DataLine> data;
  int[] labels;
  float[] angles;
  String state = "";
  HashMap<String, Integer> areas;
  int totalCases;
  String[] renderAreas;
  Integer[] renderCases;

  PieChart(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, String state) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.data = data;
    this.diameter = width*2;
    this.state = state;
    // O. Mroz, Changed pie chart setup to refreshData method to be able to refresh the data, 3:30pm 03/04/2021 
    refreshData();
  }

  void resetChart() {
    this.totalCases = 0;
    areas = new HashMap<String, Integer>();
  }

  void refreshData() {
    resetChart();
    // O. Mroz, Get state data and put it into hashmap + add total newest cases for the state, 3:30pm 01/04/2021 
    if (data != null) {
      for (int i = 0; i < data.size(); i++) {
        if (data.get(i).state.equalsIgnoreCase(state)) {
          try {
            if (this.areas.get(data.get(i).area) == null) {
              this.areas.put(data.get(i).area, data.get(i).cases);
            } else {
              totalCases -= this.areas.get(data.get(i).area);
              this.areas.put(data.get(i).area, data.get(i).cases);
              totalCases += data.get(i).cases;
            }
          }
          catch (Exception ex) {
            println(ex.getMessage());
          }
        }
      }
      // O. Mroz, Refine the state data to top 9 areas and "other" to be displayed, 3:30pm 01/04/2021 
      String[] myAreas = areas.keySet().toArray(new String[areas.size()]);
      Integer[] myCases = areas.values().toArray(new Integer[areas.size()]);
      if (myAreas.length >= 10) {
        renderAreas = new String[10];
        renderCases = new Integer[10];
      } 
      else if (myAreas.length == 0) {
        renderAreas = new String[1];
        renderCases = new Integer[1];
      }
      else {
        renderAreas = new String[myAreas.length];
        renderCases = new Integer[myAreas.length];
      }
      int temp = 0;  
      String temp2 = "";
      int otherCases = 0;
      for (int i = 0; i<myCases.length; i++) {
        otherCases += myCases[i];
      }
      for (int i=0; i < myCases.length; i++) {
        if (i < 9 ) {
          for (int j=1; j < (myCases.length-i); j++) {
            if (myCases[j-1] > myCases[j]) {
              temp = myCases[j-1];  
              myCases[j-1] = myCases[j];  
              myCases[j] = temp;  

              temp2 = myAreas[j-1];  
              myAreas[j-1] = myAreas[j];  
              myAreas[j] = temp2;
            }
            if (j == myCases.length - 1 - i) {
              renderAreas[i] = myAreas[j];
              renderCases[i] = myCases[j];
              otherCases -= myCases[j];
            }
          }
        }
      }
      // O. Mroz, Turn the top 9 areas into angles on the pie chart, 3:30pm 01/04/2021 
      renderAreas[renderAreas.length - 1] = "Other";
      renderCases[renderCases.length - 1] = otherCases;
      this.angles = new float[renderCases.length];
      for (int i = 0; i<renderCases.length; i++) {
        //println(renderAreas[i] + ": " + renderCases[i] + "\t");
        float casesToAngle = ((float)renderCases[i]/(float)totalCases)*360;
        this.angles[i] = casesToAngle;
      }
      
    }
  }

  void draw() {
    noStroke();
    fill(labelColor);
    textFont(widgetFont);
    textAlign(CENTER, CENTER);
    text(label, x, y - 36 - (diameter/2));
    float lastAngle = 0;
    // O. Mroz, Draw the pie chart arcs and area names, 3:30pm 01/04/2021 
    for (int i = 0; i < angles.length; i++) {
      fill(CHART_COLORS[i]);
      arc(x, y-3, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      if (angles[i] > 10) {
        float centerAngle = radians(angles[i])/2;
        float calculatedX = (float) ((diameter/2)+5) * cos(lastAngle + centerAngle);
        float calculatedY = (float) ((diameter/2)+5) * sin(lastAngle + centerAngle);
        //println("calculatedY: "+calculatedY);
        fill(CHART_COLORS[i]);
        textFont(widgetFont);
        textSize(12);
        if (degrees(lastAngle+centerAngle) >= 0 && degrees(lastAngle+centerAngle) <= 90) {
          textAlign(LEFT, TOP);
        } else if  (degrees(lastAngle+centerAngle) > 90 && degrees(lastAngle+centerAngle) <= 180) {
          textAlign(RIGHT, TOP);
        } else if  (degrees(lastAngle+centerAngle) > 180 && degrees(lastAngle+centerAngle) <= 270) {
          textAlign(RIGHT, BOTTOM);
        } else {
          textAlign(LEFT, BOTTOM);
        }
        text(renderAreas[i], x + calculatedX, y + calculatedY);
      }
      lastAngle += radians(angles[i]);
    }
    
    // O. Mroz Added borders and lines to the PieChart, 10:30pm 12/04/2021 
    fill(COLOR_TRANSPARENT);
    stroke(COLOR_DARKER_GREY);
    strokeWeight(2);
    lastAngle = 0;
    for (int i = 0; i < angles.length; i++) {
      float lineX = cos(lastAngle+radians(angles[i]))*((diameter/2)-2);
      float lineY = sin(lastAngle+radians(angles[i]))*((diameter/2)-2);
      line(x, y-3, x+lineX, (y-3)+lineY);
      lastAngle += radians(angles[i]);
    }
    ellipse(x, y-3, (diameter)-1, (diameter)-1);
    noStroke();
  }

  void setState(String newState) {
    this.state = newState;
  }
}
