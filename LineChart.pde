// T. Moroney, Added LineChart subclass of Widget template, 1:40pm 24/03/2021 //<>// //<>// //<>// //<>// //<>// //<>// //<>//
// S. Cataluna added methods for processing data to be used in LineChart (work in progress), 3:51pm 28/03/2021
// S. Cataluna updated LineChart, 7:45pm 29/03/2021
class LineChart extends Widget {
  String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
  int limit;
  ArrayList<DataLine> data;
  ArrayList<Date> dateList;
  int[] labels;
  int[] totalCases;
  String combinedTotalCases;
  float x;
  int y;
  int max;
  String searchResult;

  LineChart(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, ArrayList<Date> dateList, String searchResult) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.data = data;
    this.dateList = dateList;
    this.x = x;
    this.y = y;
    this.searchResult = searchResult;
    totalCases = new int[dateList.size()];
    calculateCases();
  }

  void draw() {
    fill(widgetColor);
    rect(x, y, width, height, 7);
    labelGraph();
    stroke(COLOR_BLUE);
    strokeWeight(2);
    float pointWidth = (float)width / (float)totalCases.length;
    float xCoordinate = x;
    for (int i = 0; i < totalCases.length-1; i++) {
      float yCoordinate1 = ((float)totalCases[i]/(float)max);
      float yCoordinate2 = ((float)totalCases[i+1]/(float)max);
      point(xCoordinate, (y+height)-(float)yCoordinate1*height);
      line(xCoordinate, (y+height)-(float)yCoordinate1*height, xCoordinate+pointWidth, (y+height)-(float)yCoordinate2*height);
      xCoordinate = xCoordinate+pointWidth;
    }
  }

  // S. Cataluna modified method to be more efficient - 1:30am 1/04/2021 
  void calculateCases() { // calculates new cases daily S.Cataluna modified to calculate for a given state, or countrywide - 5:16pm 31/03/2021
    int cases = 0;
    max = 0;
    int a=0;
    for (int i=0; i < data.size(); i++) {
      if ((!data.get(i).date.equals(dateList.get(a).currentDate)  && i!=0)) {
        totalCases[a] = cases;
        a++;
        cases=0;
      }
      if (searchResult.equals("")) {
        if (data.get(i).date.equals(dateList.get(a).currentDate)) {
          cases = cases + data.get(i).cases;
        }
      } else {
        if ((data.get(i).state.equalsIgnoreCase(searchResult)) && data.get(i).date.equals(dateList.get(a).currentDate)) {
          cases = cases + data.get(i).cases;
        }
      }
      if (a==dateList.size()-1) {
        totalCases[a] = cases;
      }
    }

    int combinedCases = totalCases[totalCases.length-1];
    combinedTotalCases= formatter.format(combinedCases);
    for (int i = totalCases.length-1; i > 1; i--) {
      totalCases[i] = totalCases[i] - totalCases[i-1];
      if (totalCases[i] > max) {
        max = totalCases[i];
      }
    }
  }

  void setState(String state) {
    this.searchResult = state;
  }

  void labelGraph() { // S.Cataluna added labelGraph method 7:45pm
    strokeWeight(1);
    textSize(12);
    int space = width / 13;
    int third = max/3;
    int twoThirds = max - third;
    stroke(COLOR_DARK_GREY);
    line(x, (y+height)-height/3, x+width, (y+height)-height/3);
    line(x, y+(height/3), x+width, y+(height/3));
    line(x, y, x+width, y);
    line(x, y+height, x+width, y+height);
    fill(0);
    textAlign(RIGHT, CENTER);
    text(formatter.format(third), x-5, (y+height)-height/3); // formatted y axis labels to be easier to read for user - 9:40 12/04/2021
    text(formatter.format(twoThirds), x-5, y+(height/3));
    text(formatter.format(max), x-5, y);
    text("0", x-5, y+height);
    float xCoord = x;
    int a = 0;
    for (int i = 1; a < 14; i++) {
      if (i > 11) {
        i = 0;
      }
      line(xCoord, y+height, xCoord, (y+height)+10);
      textAlign(CENTER, TOP);
      text(months[i], xCoord, (y+height)+15);
      xCoord = xCoord + space;
      a++;
    }
    textSize(22);
    textAlign(CENTER, TOP);
    if (this.id == "label-above-graph") text(label, x + (width/2)-5, y-50);
    else text(label, x + width/2, y+(height/25));
    
  }
}
