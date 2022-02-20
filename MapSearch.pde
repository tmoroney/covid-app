// T. Moroney, Added MapSearch subclass of Widget template, 1:00pm 24/03/2021
class MapSearch extends Widget {
  ArrayList<DataLine> data;
  ArrayList<Date> dateList;
  String[] SearchableElements;
  java.util.Hashtable<String, int[]> positions;
  Widget[] stateLinks;
  PImage mapImage;
  HashMap<String, Integer> statesCases; // O. Mroz added statesCases HashMap variable - 4:25PM, 08/04/2021
  int totalCases;  // O. Mroz added totalCases variable - 5:05PM, 08/04/2021

  MapSearch(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data, ArrayList<Date> dateList, PImage mapImage) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    // O. Mroz added instance variables and declared them in the constructor - 1:25AM, 08/04/2021
    this.mapImage = mapImage;
    mapImage.resize(width, height);
    super.hoverEffect = false;
    this.stateLinks = new Widget[50];
    this.data = data;
    this.dateList = dateList;
    this.totalCases = 0;
    positions = new java.util.Hashtable<String, int[]>();
    statesCases = new HashMap<String, Integer>(); // O. Mroz Declared statesCases - 5:05PM, 08/04/2021
    findCases();
    createSearchLinks();
  }

  void draw() {
    image(mapImage, x, y);
    stroke(85);
    strokeWeight(2);
    // O. Mroz Added lines to some of the tiny states - 1:25AM, 08/04/2021
    line(x + ((width / 100) * 85), y + ((height / 100) * 38), x + ((width / 100) * 89), y + ((height / 100) * 38));
    line(x + ((width / 100) * 83), y + ((height / 100) * 38), x + ((width / 100) * 89), y + ((height / 100) * 43));
    line(x + ((width / 100) * 86), y + ((height / 100) * 34), x + ((width / 100) * 89), y + ((height / 100) * 34));
    line(x + ((width / 100) * 88), y + ((height / 100) * 30), x + ((width / 100) * 91), y + ((height / 100) * 32));
    line(x + ((width / 100) * 90), y + ((height / 100) * 29), x + ((width / 100) * 94), y + ((height / 100) * 30));
    line(x + ((width / 100) * 90), y + ((height / 100) * 26), x + ((width / 100) * 94), y + ((height / 100) * 26));
    line(x + ((width / 100) * 89), y + ((height / 100) * 23), x + ((width / 100) * 94), y + ((height / 100) * 23));
    line(x + ((width / 100) * 87), y + ((height / 100) * 21), x + ((width / 100) * 86), y + ((height / 100) * 15));
    noStroke();
    drawCircles();
  }
  // O. Mroz Added and mapped all the states onto the map - 1:25AM, 08/04/2021
  void createSearchLinks() {
    stateLinks[0] =  new Widget(x + ((width / 100) * 62), y + ((height / 100) * 55), 80, 20, "Alabama", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_ALABAMA);
    stateLinks[1] =  new Widget(x + ((width / 100) * 9), y + ((height / 100) * 80), 80, 20, "Alaska", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_ALASKA);
    stateLinks[2] =  new Widget(x + ((width / 100) * 17), y + ((height / 100) * 50), 80, 20, "Arizona", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_ARIZONA );
    stateLinks[3] =  new Widget(x + ((width / 100) * 52), y + ((height / 100) * 51), 80, 20, "Arkansas", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_ARKANSAS);
    stateLinks[4] =  new Widget(x + ((width / 100) * 4), y + ((height / 100) * 40), 80, 20, "California", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_CALIFORNIA );
    stateLinks[5] =  new Widget(x + ((width / 100) * 29), y + ((height / 100) * 40), 80, 20, "Colorado", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_COLORADO);
    stateLinks[6] =  new Widget(x + ((width / 100) * 91), y + ((height / 100) * 31), 80, 20, "Connecticut", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_CONNECTICUT );
    stateLinks[7] =  new Widget(x + ((width / 100) * 88), y + ((height / 100) * 36), 80, 20, "Delaware", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_DELAWARE );
    stateLinks[8] =  new Widget(x + ((width / 100) * 73), y + ((height / 100) * 69), 80, 20, "Florida", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_FLORIDA );
    stateLinks[9] =  new Widget(x + ((width / 100) * 68), y + ((height / 100) * 59), 80, 20, "Georgia", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_GEORGIA );
    stateLinks[10] =  new Widget(x + ((width / 100) * 28), y + ((height / 100) * 90), 80, 20, "Hawaii", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_HAWAII );
    stateLinks[11] =  new Widget(x + ((width / 100) * 17), y + ((height / 100) * 25), 80, 20, "Idaho", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_IDAHO );
    stateLinks[12] =  new Widget(x + ((width / 100) * 56), y + ((height / 100) * 36), 80, 20, "Illinois", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_ILLINOIS );
    stateLinks[13] =  new Widget(x + ((width / 100) * 61), y + ((height / 100) * 39), 80, 20, "Indiana", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_INDIANA );
    stateLinks[14] =  new Widget(x + ((width / 100) * 49), y + ((height / 100) * 32), 80, 20, "Iowa", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_IOWA );
    stateLinks[15] =  new Widget(x + ((width / 100) * 40), y + ((height / 100) * 42), 80, 20, "Kansas", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_KANSAS );
    stateLinks[16] =  new Widget(x + ((width / 100) * 64), y + ((height / 100) * 44), 80, 20, "Kentucky", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_KENTUCKY );
    stateLinks[17] =  new Widget(x + ((width / 100) * 52), y + ((height / 100) * 63), 80, 20, "Louisiana", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_LOUISIANA );
    stateLinks[18] =  new Widget(x + ((width / 100) * 86), y + ((height / 100) * 15), 80, 20, "Maine", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MAINE );
    stateLinks[19] =  new Widget(x + ((width / 100) * 88), y + ((height / 100) * 42), 80, 20, "Maryland", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MARYLAND );
    stateLinks[20] =  new Widget(x + ((width / 100) * 96), y + ((height / 100) * 24), 80, 20, "Massachusetts", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MASSACHUSETTS );
    stateLinks[21] =  new Widget(x + ((width / 100) * 63), y + ((height / 100) * 28), 80, 20, "Michigan", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MICHIGAN );
    stateLinks[22] =  new Widget(x + ((width / 100) * 48), y + ((height / 100) * 19), 80, 20, "Minnesota", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MINNESOTA );
    stateLinks[23] =  new Widget(x + ((width / 100) * 56), y + ((height / 100) * 59), 80, 20, "Mississippi", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MISSISSIPPI );
    stateLinks[24] =  new Widget(x + ((width / 100) * 51), y + ((height / 100) * 42), 80, 20, "Missouri", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MISSOURI );
    stateLinks[25] =  new Widget(x + ((width / 100) * 25), y + ((height / 100) * 15), 80, 20, "Montana", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_MONTANA );
    stateLinks[26] =  new Widget(x + ((width / 100) * 39), y + ((height / 100) * 34), 80, 20, "Nebraska", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEBRASKA );
    stateLinks[27] =  new Widget(x + ((width / 100) * 11), y + ((height / 100) * 35), 80, 20, "Nevada", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEVADA );
    stateLinks[28] =  new Widget(x + ((width / 100) * 95), y + ((height / 100) * 21), 80, 20, "New Hampshire", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEW_HAMPSHIRE );
    stateLinks[28].align(LEFT, CENTER);
    stateLinks[29] =  new Widget(x + ((width / 100) * 89), y + ((height / 100) * 33), 80, 20, "New Jersey", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEW_JERSEY );
    stateLinks[30] =  new Widget(x + ((width / 100) * 27), y + ((height / 100) * 53), 80, 20, "New Mexico", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEW_MEXICO );
    stateLinks[31] =  new Widget(x + ((width / 100) * 77), y + ((height / 100) * 26), 80, 20, "New York", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NEW_YORK );
    stateLinks[32] =  new Widget(x + ((width / 100) * 75), y + ((height / 100) * 48), 80, 20, "North Carolina", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NORTH_CAROLINA );
    stateLinks[33] =  new Widget(x + ((width / 100) * 38), y + ((height / 100) * 15), 80, 20, "North Dakota", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_NORTH_DAKOTA );
    stateLinks[34] =  new Widget(x + ((width / 100) * 67), y + ((height / 100) * 35), 80, 20, "Ohio", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_OHIO );
    stateLinks[35] =  new Widget(x + ((width / 100) * 43), y + ((height / 100) * 52), 80, 20, "Oklahoma", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_OKLAHOMA );
    stateLinks[36] =  new Widget(x + ((width / 100) * 7), y + ((height / 100) * 20), 80, 20, "Oregon", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_OREGON );
    stateLinks[37] =  new Widget(x + ((width / 100) * 75), y + ((height / 100) * 32), 80, 20, "Pennsylvania", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_PENNSYLVANIA );
    stateLinks[38] =  new Widget(x + ((width / 100) * 95), y + ((height / 100) * 28), 80, 20, "Rhode Island", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_RHODE_ISLAND );
    stateLinks[39] =  new Widget(x + ((width / 100) * 73), y + ((height / 100) * 54), 80, 20, "South Carolina", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_SOUTH_CAROLINA );
    stateLinks[40] =  new Widget(x + ((width / 100) * 39), y + ((height / 100) * 25), 80, 20, "South Dakota", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_SOUTH_DAKOTA );
    stateLinks[41] =  new Widget(x + ((width / 100) * 61), y + ((height / 100) * 49), 80, 20, "Tennessee", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_TENNESSEE );
    stateLinks[42] =  new Widget(x + ((width / 100) * 39), y + ((height / 100) * 62), 80, 20, "Texas", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_TEXAS );
    stateLinks[43] =  new Widget(x + ((width / 100) * 19), y + ((height / 100) * 38), 80, 20, "Utah", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_UTAH );
    stateLinks[44] =  new Widget(x + ((width / 100) * 78), y + ((height / 100) * 11), 80, 20, "Vermont", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_VERMONT );
    stateLinks[45] =  new Widget(x + ((width / 100) * 74), y + ((height / 100) * 43), 80, 20, "Virginia", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_VIRGINIA );
    stateLinks[46] =  new Widget(x + ((width / 100) * 10), y + ((height / 100) * 10), 80, 20, "Washington", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_WASHINGTON );
    stateLinks[47] =  new Widget(x + ((width / 100) * 71), y + ((height / 100) * 40), 80, 20, "West Virginia", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_WEST_VIRGINIA );
    stateLinks[48] =  new Widget(x + ((width / 100) * 54), y + ((height / 100) * 23), 80, 20, "Wisconsin", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_WISCONSIN );
    stateLinks[49] =  new Widget(x + ((width / 100) * 27), y + ((height / 100) * 28), 80, 20, "Wyoming", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, SEARCH_WYOMING );

    // O. Mroz edited the properties of each state label - 1:25AM, 08/04/2021
    for (int i = 0; i < stateLinks.length; i++) {
      stateLinks[i].showBorder(false);
      stateLinks[i].setHoverEffect(true);
      stateLinks[i].setFontSize(12);
      //stateLinks[i].setFontColor(CHART_COLORS[i%10]);
    }
  }
  // O. Mroz added drawCircles method for drawing the circles that show how many cases a state has relative to the totalCases - 4:50PM, 08/04/2021
  void drawCircles() {
    fill(200, 40, 20, 170);
    java.util.Set<java.util.Map.Entry<String, Integer>> entrySet = statesCases.entrySet();
    for (java.util.Map.Entry<String, Integer> entry : entrySet) {
      final float MIN_DIAMETER = 5.0;
      final float MAX_DIAMETER = 40.0;
      final int OFFSET_X = 40;
      final int OFFSET_Y = 11;
      float diameter = MIN_DIAMETER + (((float)entry.getValue() / (float)this.totalCases) * MAX_DIAMETER*10);
      switch(entry.getKey()) {
      case "Alabama":
        ellipse(x + ((width / 100) * 62) + OFFSET_X, y + ((height / 100) * 55) + OFFSET_Y, diameter, diameter);
        break;
      case "Alaska":
        ellipse(x + ((width / 100) * 9) + OFFSET_X, y + ((height / 100) * 80) + OFFSET_Y, diameter, diameter);
        break;
      case "Arizona":
        ellipse(x + ((width / 100) * 17) + OFFSET_X, y + ((height / 100) * 50) + OFFSET_Y, diameter, diameter);
        break;
      case "Arkansas":
        ellipse(x + ((width / 100) * 52) + OFFSET_X, y + ((height / 100) * 51) + OFFSET_Y, diameter, diameter);
        break;
      case "California":
        ellipse(x + ((width / 100) * 4) + OFFSET_X, y + ((height / 100) * 40) + OFFSET_Y, diameter, diameter);
        break;
      case "Colorado":
        ellipse(x + ((width / 100) * 29) + OFFSET_X, y + ((height / 100) * 40) + OFFSET_Y, diameter, diameter);
        break;
      case "Connecticut":
        ellipse(x + ((width / 100) * 82) + OFFSET_X, y + ((height / 100) * 27) + OFFSET_Y, diameter, diameter);
        break;
      case "Delaware":
        ellipse(x + ((width / 100) * 79) + OFFSET_X, y + ((height / 100) * 36) + OFFSET_Y, diameter, diameter);
        break;
      case "Florida":
        ellipse(x + ((width / 100) * 73) + OFFSET_X, y + ((height / 100) * 69) + OFFSET_Y, diameter, diameter);
        break;
      case "Georgia":
        ellipse(x + ((width / 100) * 68) + OFFSET_X, y + ((height / 100) * 59) + OFFSET_Y, diameter, diameter);
        break;
      case "Hawaii":
        ellipse(x + ((width / 100) * 28) + OFFSET_X, y + ((height / 100) * 90) + OFFSET_Y, diameter, diameter);
        break;
      case "Idaho":
        ellipse(x + ((width / 100) * 17) + OFFSET_X, y + ((height / 100) * 25) + OFFSET_Y, diameter, diameter);
        break;
      case "Illinois":
        ellipse(x + ((width / 100) * 56) + OFFSET_X, y + ((height / 100) * 36) + OFFSET_Y, diameter, diameter);
        break;
      case "Indiana":
        ellipse(x + ((width / 100) * 61) + OFFSET_X, y + ((height / 100) * 39) + OFFSET_Y, diameter, diameter);
        break;
      case "Iowa":
        ellipse(x + ((width / 100) * 49) + OFFSET_X, y + ((height / 100) * 32) + OFFSET_Y, diameter, diameter);
        break;
      case "Kansas":
        ellipse(x + ((width / 100) * 40) + OFFSET_X, y + ((height / 100) * 42) + OFFSET_Y, diameter, diameter);
        break;
      case "Kentucky":
        ellipse(x + ((width / 100) * 64) + OFFSET_X, y + ((height / 100) * 44) + OFFSET_Y, diameter, diameter);
        break;
      case "Louisiana":
        ellipse(x + ((width / 100) * 52) + OFFSET_X, y + ((height / 100) * 63) + OFFSET_Y, diameter, diameter);
        break;
      case "Maine":
        ellipse(x + ((width / 100) * 86) + OFFSET_X, y + ((height / 100) * 15) + OFFSET_Y, diameter, diameter);
        break;
      case "Maryland":
        ellipse(x + ((width / 100) * 77) + OFFSET_X, y + ((height / 100) * 36) + OFFSET_Y, diameter, diameter);
        break;
      case "Massachusetts":
        ellipse(x + ((width / 100) * 84) + OFFSET_X, y + ((height / 100) * 24) + OFFSET_Y, diameter, diameter);
        break;
      case "Michigan":
        ellipse(x + ((width / 100) * 63) + OFFSET_X, y + ((height / 100) * 28) + OFFSET_Y, diameter, diameter);
        break;
      case "Minnesota":
        ellipse(x + ((width / 100) * 48) + OFFSET_X, y + ((height / 100) * 19) + OFFSET_Y, diameter, diameter);
        break;
      case "Mississippi":
        ellipse(x + ((width / 100) * 56) + OFFSET_X, y + ((height / 100) * 59) + OFFSET_Y, diameter, diameter);
        break;
      case "Missouri":
        ellipse(x + ((width / 100) * 51) + OFFSET_X, y + ((height / 100) * 42) + OFFSET_Y, diameter, diameter);
        break;
      case "Montana":
        ellipse(x + ((width / 100) * 25) + OFFSET_X, y + ((height / 100) * 15) + OFFSET_Y, diameter, diameter);
        break;
      case "Nebraska":
        ellipse(x + ((width / 100) * 39) + OFFSET_X, y + ((height / 100) * 34) + OFFSET_Y, diameter, diameter);
        break;
      case "Nevada":
        ellipse(x + ((width / 100) * 11) + OFFSET_X, y + ((height / 100) * 35) + OFFSET_Y, diameter, diameter);
        break;
      case "New Hampshire":
        ellipse(x + ((width / 100) * 83) + OFFSET_X, y + ((height / 100) * 21) + OFFSET_Y, diameter, diameter);
        break;
      case "New Jersey":
        ellipse(x + ((width / 100) * 80) + OFFSET_X, y + ((height / 100) * 32) + OFFSET_Y, diameter, diameter);
        break;
      case "New Mexico":
        ellipse(x + ((width / 100) * 27) + OFFSET_X, y + ((height / 100) * 53) + OFFSET_Y, diameter, diameter);
        break;
      case "New York":
        ellipse(x + ((width / 100) * 77) + OFFSET_X, y + ((height / 100) * 26) + OFFSET_Y, diameter, diameter);
        break;
      case "North Carolina":
        ellipse(x + ((width / 100) * 75) + OFFSET_X, y + ((height / 100) * 48) + OFFSET_Y, diameter, diameter);
        break;
      case "North Dakota":
        ellipse(x + ((width / 100) * 38) + OFFSET_X, y + ((height / 100) * 15) + OFFSET_Y, diameter, diameter);
        break;
      case "Ohio":
        ellipse(x + ((width / 100) * 67) + OFFSET_X, y + ((height / 100) * 35) + OFFSET_Y, diameter, diameter);
        break;
      case "Oklahoma":
        ellipse(x + ((width / 100) * 43) + OFFSET_X, y + ((height / 100) * 52) + OFFSET_Y, diameter, diameter);
        break;
      case "Oregon":
        ellipse(x + ((width / 100) * 7) + OFFSET_X, y + ((height / 100) * 20) + OFFSET_Y, diameter, diameter);
        break;
      case "Pennsylvania":
        ellipse(x + ((width / 100) * 75) + OFFSET_X, y + ((height / 100) * 32) + OFFSET_Y, diameter, diameter);
        break;
      case "Rhode Island":
        ellipse(x + ((width / 100) * 85) + OFFSET_X, y + ((height / 100) * 27) + OFFSET_Y, diameter, diameter);
        break;
      case "South Carolina":
        ellipse(x + ((width / 100) * 73) + OFFSET_X, y + ((height / 100) * 54) + OFFSET_Y, diameter, diameter);
        break;
      case "South Dakota":
        ellipse(x + ((width / 100) * 39) + OFFSET_X, y + ((height / 100) * 25) + OFFSET_Y, diameter, diameter);
        break;
      case "Tennessee":
        ellipse(x + ((width / 100) * 61) + OFFSET_X, y + ((height / 100) * 49) + OFFSET_Y, diameter, diameter);
        break;
      case "Texas":
        ellipse(x + ((width / 100) * 39) + OFFSET_X, y + ((height / 100) * 62) + OFFSET_Y, diameter, diameter);
        break;
      case "Utah":
        ellipse(x + ((width / 100) * 19) + OFFSET_X, y + ((height / 100) * 38) + OFFSET_Y, diameter, diameter);
        break;
      case "Vermont":
        ellipse(x + ((width / 100) * 81) + OFFSET_X, y + ((height / 100) * 20) + OFFSET_Y, diameter, diameter);
        break;
      case "Virginia":
        ellipse(x + ((width / 100) * 74) + OFFSET_X, y + ((height / 100) * 43) + OFFSET_Y, diameter, diameter);
        break;
      case "Washington":
        ellipse(x + ((width / 100) * 10) + OFFSET_X, y + ((height / 100) * 10) + OFFSET_Y, diameter, diameter);
        break;
      case "West Virginia":
        ellipse(x + ((width / 100) * 71) + OFFSET_X, y + ((height / 100) * 40) + OFFSET_Y, diameter, diameter);
        break;
      case "Wisconsin":
        ellipse(x + ((width / 100) * 54) + OFFSET_X, y + ((height / 100) * 23) + OFFSET_Y, diameter, diameter);
        break;
      case "Wyoming":
        ellipse(x + ((width / 100) * 27) + OFFSET_X, y + ((height / 100) * 28) + OFFSET_Y, diameter, diameter);
        break;
      default:
        break;
      }
    }
  }
  
  void findCases() { // T. Moroney, Added method to calculate cases for each state store in hashmap, 5:20pm 08/04/2021
    String latestDate = dateList.get(dateList.size()-1).currentDate;
    String previousDate = dateList.get(dateList.size()-2).currentDate;
    if (data != null) {
      for (int i = 0; i < data.size(); i++) {
        if (data.get(i).date.equalsIgnoreCase(previousDate)) {
          try {
            if (!this.statesCases.containsKey(data.get(i).state)) {
              this.statesCases.put(data.get(i).state, -data.get(i).cases);
            } else {
              int previousCases = this.statesCases.get(data.get(i).state);
              this.statesCases.put(data.get(i).state, previousCases - data.get(i).cases);
            }
          }
          catch (Exception ex) {
            println(ex.getMessage());
          }
        }
        else if (data.get(i).date.equalsIgnoreCase(latestDate)) {
          try {
            if (!this.statesCases.containsKey(data.get(i).state)) {
              this.statesCases.put(data.get(i).state, data.get(i).cases);
            } else {
              int previousCases = this.statesCases.get(data.get(i).state);
              this.statesCases.put(data.get(i).state, previousCases + data.get(i).cases);
            }
          }
          catch (Exception ex) {
            println(ex.getMessage());
          }
        }
      }
    }
    Integer[] myCases = statesCases.values().toArray(new Integer[statesCases.size()]);
    for (int i=0; i<myCases.length; i++) {
      totalCases = totalCases+myCases[i];
    }
    //System.out.println("Map Case numbers for "+myCases[3]);
  }
}
