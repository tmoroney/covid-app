// T. Moroney, Added RankingsInfo class as extension of widget class, 2:30pm 10/04/2021
class RankingsInfo extends Widget {
  int x;
  int y;
  String label;
  ArrayList<DataLine> data;
  ArrayList<Date> dateList;
  int[] totalCases;
  int sevenDayTotal;
  int sevenDayAverage;
  int combinedCases;
  String bestDay;
  String worstDay;

  RankingsInfo(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, ArrayList<Date> dateList) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = true;
    this.data = data;
    this.dateList = dateList;
    this.x = x;
    this.y = y;
    this.label = label;
    totalCases = new int[dateList.size()];
    combinedCases = 0;
    sevenDayTotal = 0;
    sevenDayAverage = 0;
    calculateStats();
  }
  
  // T. Moroney, Creates hashmap of cases for each day across country + calculates total cases and latest 7-day average, 3:50pm 10/04/2021
  // T. Moroney, Added calculations for more stats i.e. cases over past week + day with least cases + day with most cases, 11:40pm 12/04/2021
  // T. Moroney, Removed outer loop and changed method for getting total cases for each date (speed up program), 11:30pm 13/04/2021
  void calculateStats() {
    int cases = 0;
    int a=0;
    for (int i=0; i < data.size(); i++) {
      if ((!data.get(i).date.equals(dateList.get(a).currentDate)  && i!=0)) {
        totalCases[a] = cases;
        a++;
        cases=0;
      }
      if (data.get(i).date.equals(dateList.get(a).currentDate)) {
        cases = cases + data.get(i).cases;
      }
      if (a==dateList.size()-1) {
        totalCases[a] = cases;
      }
    }
    int totalCasesCopy[] = totalCases.clone();
    for (int i=1; i<totalCases.length; i++) {
      totalCases[i] = totalCases[i] - totalCasesCopy[i-1];
    }
    int min = 1000000;
    int max = 0;
    for (int i=0; i<totalCases.length; i++) {
      combinedCases = combinedCases+totalCases[i]; // total cases
      if (i >= totalCases.length-7) {
        sevenDayTotal = sevenDayTotal + totalCases[i]; // total cases over last 7 days
      }
      if (totalCases[i] < min && i!=0) {
        min = totalCases[i];
        bestDay = dateList.get(i).currentDate;  // finds day with least cases
      }
      if (totalCases[i] > max) {
        max = totalCases[i];
        worstDay = dateList.get(i).currentDate;  // finds day with the most cases
      }
      System.out.println("Cases on "+dateList.get(i).currentDate+" were "+totalCases[i]);
    }
    sevenDayAverage = sevenDayTotal/7;   // calculates latest 7-day average
  }

  // T. Moroney, Added text to show statistics on the rankings page, 11:30pm 12/04/2021
  void draw() {
    textFont(widgetFont);
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(34);
    text(label, x, y);
    textSize(18);
    // O. Mroz, Changed order and locations of the information for visual purposes, 3:00pm 16/04/2021 
    final int RESULT_OFFSET = 355;
    text("Total Cases Reported:", x, y+60);
    text(formatter.format(combinedCases), x+RESULT_OFFSET, y+60);
    
    text("Cases reported in the past week:", x, y+100);
    text(formatter.format(sevenDayTotal), x+RESULT_OFFSET, y+100);
    
    text("Average cases over the past 7 days:", x, y+140);
    text(formatter.format(sevenDayAverage), x+RESULT_OFFSET, y+140);
    
    text("Day with the MOST cases reported:", x, y+180);
    text(worstDay, x+RESULT_OFFSET, y+180);
    
    text("Day with the LEAST cases reported:", x, y+220);
    text(bestDay, x+RESULT_OFFSET, y+220);
  }
}
