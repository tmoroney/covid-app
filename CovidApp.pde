// O. Mroz, Added 4 screen setup functions, 3:30pm 22/03/2021 //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.text.DecimalFormat;
final DecimalFormat formatter = new DecimalFormat("#,###"); // S. Cataluna added decimal formatter to format the results with commas to the user - 9:40 12/04/2021
PFont robotoFont;
Screen activeScreen;
DataLine dataPoint; // S.Cataluna added BufferedReader & ArrayList setup - 7:52pm 22/03/2021
ArrayList<DataLine> dataList;
ArrayList<DataLine> list;
ArrayList<Date> dateList; // S. Cataluna added dateList ArrayList used for sorting by date - 6:08pm 25/03/2021
// S. Cataluna removed stateList (redundant) - 4:27pm - 8/04/2021
BufferedReader reader;
Screen[] screens;
LineChart lineChart;
TextSearch focus;
boolean on = false;
String searchResult; // O. Mroz, Added searchResult variable to store the result of future search, 4:30pm 29/03/2021
PImage mapImage;
PImage logoImage;

void settings() {
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  // O. Mroz added stateResult variable to store the result of the search globally. 05:40 25/03/2021
  searchResult = "California";
  // S. Cataluna implemented readData() method - 7:52pm 22/03/2021
  list = readData();
  // O. Mroz, Added Roboto Font, 3:30pm 22/03/2021  
  robotoFont = createFont("Roboto-Regular.ttf", 20);
  mapImage = loadImage("mapImage.png");
  logoImage = loadImage("covidImage.png");
  // O. Mroz, Added 4 screen setup functions, 3:30pm 22/03/2021  
  setupScreens();
  setupSearchScreen();
  setupRankingScreen();
  setupResultScreen();
}

ArrayList readData() {
  // S. Cataluna added readData() method - 7:52pm 22/03/2021
  reader = createReader("cases-1M.csv");
  ArrayList<DataLine> dataList = new ArrayList<DataLine>();
  dateList = new ArrayList();

  try { // method takes in the file and separates all the info and creates a new dataLine object and stores it into an ArrayList
    boolean endOfFile = false;
    int i = 1;
    while (!endOfFile) {
      String dataLine = reader.readLine();
      if (dataLine != null) {
        String[] data = dataLine.split(",");
        String date = data[DATE_INDEX];
        String area = data[AREA_INDEX];
        String state = data[STATE_INDEX];
        int geoID =  int (data[GEOID_INDEX]);
        int cases = int (data[CASES_INDEX]);
        String country = data[COUNTRY_INDEX];
        Date theDate = new Date(date); // S. Cataluna added date adding function to file reader, creates new date object every line and adds only unique dates to list - 6:08pm 25/03/2021
        // S. Cataluna deleted redundant State class 4:27pm 8/04/2021
        if (i == 1) {
          dateList.add(theDate);
        } else if (!date.equals(dateList.get(dateList.size()-1).currentDate)) {
          dateList.add(theDate);
        }
        DataLine dataPoint = new DataLine(date, area, state, geoID, cases, country);
        dataList.add(dataPoint);
        i++;
      } else endOfFile = true;
    }
    reader.close();
  }
  catch(IOException e) {
    e.printStackTrace();
  }
  return dataList;
}

void setupScreens() {
  screens = new Screen[5];
  for (int i = 0; i < screens.length; i++) {
    screens[i] = new Screen();
  }
  // initial screen = search screen
  activeScreen = screens[0];
}
void setupSearchScreen() {
  // O. Mroz, Changed background color to COLOR_BABY_BLUE, 5:00pm 10/04/2021 
  screens[0].setBackgroundColor(COLOR_BABY_BLUE);
  // O. Mroz, Added a header to the search screen, 5:00pm 10/04/2021 
  //Widget searchPageHeader = new Widget(MARGIN, MARGIN, 120, 40, "Search Page", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  //searchPageHeader.showBorder(false);
  //searchPageHeader.align(LEFT, CENTER);
  //searchPageHeader.setHoverEffect(false);
  //searchPageHeader.setFontSize(30);
  //screens[0].addWidget(searchPageHeader);
  Widget searchScreenBtn = new Widget(SCREEN_X - 120 - (MARGIN+140), MARGIN, 120, 40, "Search", COLOR_SALMON, COLOR_BLACK, robotoFont, true, GO_TO_SEARCH_SCREEN);
  Widget rankingsScreenBtn = new Widget(SCREEN_X - 120 - MARGIN, MARGIN, 120, 40, "Rankings", COLOR_AQUAMARINE, COLOR_BLACK, robotoFont, true, GO_TO_RANKING_SCREEN);
  screens[0].addWidget(searchScreenBtn);
  screens[0].addWidget(rankingsScreenBtn);
  // O. Mroz, Development results screen button, 4:30pm 29/03/2021 
  //Widget tempButton = new Widget(SCREEN_X - 120 - (MARGIN+300), MARGIN, 140, 40, "DEV: results", COLOR_AQUAMARINE, COLOR_BLACK, robotoFont, true, GO_TO_RESULT_SCREEN);
  //screens[0].addWidget(tempButton);
  // O. Mroz, Added header label and description for the search box, 5:00pm 29/03/2021
  Widget searchHeaderLabel = new Widget(MARGIN, MARGIN+NAVBAR_HEIGHT-0, 120, 40, "Search by State", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  searchHeaderLabel.showBorder(false);
  searchHeaderLabel.align(LEFT, TOP);
  searchHeaderLabel.setHoverEffect(false);
  searchHeaderLabel.setFontSize(26);
  String searchDescription = "Type the name of the state you're looking for";
  Widget searchBoxDesc = new Widget(MARGIN, MARGIN+NAVBAR_HEIGHT+46, 120, 40, searchDescription, COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  searchBoxDesc.showBorder(false);
  searchBoxDesc.align(LEFT, TOP);
  searchBoxDesc.setHoverEffect(false);
  searchBoxDesc.setFontSize(16);
  screens[0].addWidget(searchHeaderLabel);
  screens[0].addWidget(searchBoxDesc);

  // S. Cataluna added temporary work in progress search bar - 6:30pm 1/04/2021
  TextSearch textInput=new TextSearch(MARGIN, SCREEN_Y - MAP_BOX_HEIGHT - MARGIN, SCREEN_X - (MARGIN*3) - MAP_BOX_WIDTH, 50, "Search", COLOR_WHITE, COLOR_DARKER_GREY, robotoFont, true, TEXT_WIDGET, 30, list);
  focus = null;
  screens[0].addWidget(textInput);

  // O. Mroz, Added background box for cleaner UI, 3:30pm 10/04/2021
  Widget mapBox = new Widget(SCREEN_X - MARGIN - MAP_BOX_WIDTH, SCREEN_Y - MAP_BOX_HEIGHT - MARGIN, MAP_BOX_WIDTH, MAP_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  mapBox.setHoverEffect(false);
  mapBox.setBoxRadius(6);
  screens[0].addWidget(mapBox);
  // O. Mroz, Added map header and description, 3:30pm 10/04/2021
  Widget mapHeading = new Widget(SCREEN_X - (MAP_BOX_WIDTH) - MARGIN, MARGIN+NAVBAR_HEIGHT-0, 120, 40, "Interactive map", COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  mapHeading.showBorder(false);
  mapHeading.align(LEFT, TOP);
  mapHeading.setHoverEffect(false);
  mapHeading.setFontSize(26);
  String mapDescription = "Click on a state to see detailed covid information";
  Widget mapDesc = new Widget(SCREEN_X - (MAP_BOX_WIDTH) - MARGIN, MARGIN+NAVBAR_HEIGHT+46, 120, 40, mapDescription, COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  mapDesc.showBorder(false);
  mapDesc.align(LEFT, TOP);
  mapDesc.setHoverEffect(false);
  mapDesc.setFontSize(16);
  // O. Mroz, Added interactable map, 3:30pm 10/04/2021
  MapSearch mapSearch = new MapSearch(SCREEN_X - MAP_WIDTH - (MARGIN + 70), SCREEN_Y - MAP_BOX_HEIGHT - MARGIN + 20, MAP_WIDTH, MAP_HEIGHT, "Click on a state for details", COLOR_SALMON, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, dateList, mapImage);
  screens[0].addWidget(mapSearch);
  for (int i = 0; i < mapSearch.stateLinks.length; i++) {
    screens[0].addWidget(mapSearch.stateLinks[i]);
  }
  screens[0].addWidget(mapHeading);
  screens[0].addWidget(mapDesc);
}  
void setupRankingScreen() {//B. Paisley updated widget List order, 17:36 12/04/2021
  screens[1].setBackgroundColor(COLOR_BABY_BLUE);
  RankedList rankedList = new RankedList(SCREEN_X - RANKED_LIST_WIDTH - MARGIN - SCROLLBAR_WIDTH - (SCROLLBAR_WIDTH/2) - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT + 100, RANKED_LIST_WIDTH, RANKED_LIST_HEIGHT, "Ranked List", COLOR_WHITE, COLOR_BLACK, robotoFont, false, EVENT_NULL, list);
  screens[1].addWidget(rankedList);

  // O. Mroz, Added background boxes for better UI, 7:30pm 15/04/2021
  Widget infoBox = new Widget(MARGIN, MARGIN + NAVBAR_HEIGHT, INFO_BOX_WIDTH, INFO_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  infoBox.setHoverEffect(false);
  infoBox.setBoxRadius(6);
  screens[1].addWidget(infoBox);
  Widget lineChartBox = new Widget(MARGIN, SCREEN_Y - LINECHART_BOX_HEIGHT - MARGIN, LINECHART_BOX_WIDTH, LINECHART_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  lineChartBox.setHoverEffect(false);
  lineChartBox.setBoxRadius(6);
  screens[1].addWidget(lineChartBox);

  Widget searchScreenBtn = new Widget(SCREEN_X - 120 - (MARGIN+140), MARGIN, 120, 40, "Search", COLOR_AQUAMARINE, COLOR_BLACK, robotoFont, true, GO_TO_SEARCH_SCREEN);
  Widget rankingsScreenBtn = new Widget(SCREEN_X - 120 - MARGIN, MARGIN, 120, 40, "Rankings", COLOR_SALMON, COLOR_BLACK, robotoFont, true, GO_TO_RANKING_SCREEN);
  screens[1].addWidget(searchScreenBtn);
  screens[1].addWidget(rankingsScreenBtn);

  LineChart totalLineChart = new LineChart(MARGIN+90, SCREEN_Y/2 + 100, 400, 220, "Total Cases over time", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, dateList, "");
  totalLineChart.setID("label-above-graph");
  ScrollBar scrollBar = new ScrollBar(SCREEN_X - MARGIN - SCROLLBAR_WIDTH - (SCROLLBAR_WIDTH/2), MARGIN + NAVBAR_HEIGHT + 100, SCROLLBAR_WIDTH, 70, "Scroll Bar", COLOR_WHITE, COLOR_BLACK, robotoFont, false, SCROLL_BAR, SCREEN_Y - MARGIN);
  screens[1].addWidget(totalLineChart);
  screens[1].addWidget(scrollBar);

  RankingsInfo overviewInfo = new RankingsInfo(MARGIN+30, MARGIN+NAVBAR_HEIGHT+40, 0, 5, "Overview of United States", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, dateList);
  screens[1].addWidget(overviewInfo);
  
  Widget changeButton = new Widget(SCREEN_X - EACH_RANKINGS_FILTER_WIDTH - MARGIN - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT, EACH_RANKINGS_FILTER_WIDTH, EACH_RANKINGS_FILTER_HEIGHT, "High to Low", COLOR_FREESIA, COLOR_BLACK, robotoFont, true, 200000000);
  changeButton.setID("high-to-low");
  screens[1].addWidget(changeButton);
  Widget changeButton2 = new Widget(SCREEN_X - EACH_RANKINGS_FILTER_WIDTH - MARGIN - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT + EACH_RANKINGS_FILTER_HEIGHT + 9, EACH_RANKINGS_FILTER_WIDTH, EACH_RANKINGS_FILTER_HEIGHT, "Alphabetical", COLOR_SALMON, COLOR_BLACK, robotoFont, true, 200000001);
  changeButton2.setID("alphabetical");
  screens[1].addWidget(changeButton2);
  Widget dateButton1 = new Widget(SCREEN_X - EACH_RANKINGS_FILTER_WIDTH*2 - MARGIN*2 - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT + EACH_RANKINGS_FILTER_HEIGHT+ 9, EACH_RANKINGS_FILTER_WIDTH, EACH_RANKINGS_FILTER_HEIGHT, "Set Dates", COLOR_FREESIA, COLOR_BLACK, robotoFont, true, 200000002);
  dateButton1.setID("test1");
  screens[1].addWidget(dateButton1);
  //Widget dateButton2 = new Widget(SCREEN_X - EACH_RANKINGS_FILTER_WIDTH*2 - MARGIN*2 - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT, EACH_RANKINGS_FILTER_WIDTH, EACH_RANKINGS_FILTER_HEIGHT, "Date test 2", COLOR_FREESIA, COLOR_BLACK, robotoFont, true, 200000003);
  //dateButton2.setID("test2");
  //screens[1].addWidget(dateButton2);
  DateSlider dateSlider = new DateSlider(SCREEN_X - EACH_RANKINGS_FILTER_WIDTH*2 - MARGIN*2 - SCROLLBAR_OFFSET, MARGIN + NAVBAR_HEIGHT + EACH_RANKINGS_FILTER_HEIGHT/2, EACH_RANKINGS_FILTER_WIDTH, EACH_RANKINGS_FILTER_HEIGHT, "", COLOR_FREESIA, COLOR_BLACK, robotoFont, true,EVENT_NULL, list);
  dateSlider.setID("date-slider");
  screens[1].addWidget(dateSlider);
}
void setupResultScreen() {
  // O. Mroz, added result screen heading, 3:30pm 01/04/2021 
  screens[2].setBackgroundColor(COLOR_BABY_BLUE);
  Widget resultsHeading = new Widget(MARGIN, MARGIN, 120, 40, "Results for: " + searchResult, COLOR_TRANSPARENT, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  resultsHeading.setID("resultHeading");
  resultsHeading.align(LEFT, CENTER);
  resultsHeading.showBorder(false);
  resultsHeading.setHoverEffect(false);
  resultsHeading.setFontSize(26);
  screens[2].addWidget(resultsHeading);

  Widget searchScreenBtn = new Widget(SCREEN_X - 120 - (MARGIN+140), MARGIN, 120, 40, "Search", COLOR_AQUAMARINE, COLOR_BLACK, robotoFont, true, GO_TO_SEARCH_SCREEN);
  Widget rankingsScreenBtn = new Widget(SCREEN_X - 120 - MARGIN, MARGIN, 120, 40, "Rankings", COLOR_AQUAMARINE, COLOR_BLACK, robotoFont, true, GO_TO_RANKING_SCREEN);
  screens[2].addWidget(searchScreenBtn);
  screens[2].addWidget(rankingsScreenBtn);

  // O. Mroz, Added background widgets for style, 3:30pm 01/04/2021 
  Widget topLeftBox = new Widget(MARGIN, MARGIN + NAVBAR_HEIGHT, RESULTS_GRAPH_BOX_WIDTH, RESULTS_GRAPH_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  Widget topRightBox = new Widget(SCREEN_X - MARGIN - RESULTS_GRAPH_BOX_WIDTH, MARGIN + NAVBAR_HEIGHT, RESULTS_GRAPH_BOX_WIDTH, RESULTS_GRAPH_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  Widget bottomLeftBox = new Widget(MARGIN, SCREEN_Y - MARGIN - RESULTS_GRAPH_BOX_HEIGHT, RESULTS_GRAPH_BOX_WIDTH, RESULTS_GRAPH_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  Widget bottomRightBox = new Widget(SCREEN_X - MARGIN - RESULTS_GRAPH_BOX_WIDTH, SCREEN_Y - MARGIN - RESULTS_GRAPH_BOX_HEIGHT, RESULTS_GRAPH_BOX_WIDTH, RESULTS_GRAPH_BOX_HEIGHT, "", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL);
  topLeftBox.setHoverEffect(false);
  topRightBox.setHoverEffect(false);
  bottomLeftBox.setHoverEffect(false);
  bottomRightBox.setHoverEffect(false);
  topLeftBox.setBoxRadius(6);
  topRightBox.setBoxRadius(6);
  bottomLeftBox.setBoxRadius(6);
  bottomRightBox.setBoxRadius(6);

  screens[2].addWidget(topLeftBox);
  screens[2].addWidget(topRightBox);
  screens[2].addWidget(bottomLeftBox);
  screens[2].addWidget(bottomRightBox);

  // T. Moroney, Added Gauge top left corner, 4:00pm 01/04/2021 
  Gauge theGauge = new Gauge(SCREEN_X/4, SCREEN_Y/3, 180, 180, "", color(255, 0, 0), color(255, 0, 0), robotoFont, true, EVENT_NULL, list, dateList, searchResult);
  screens[2].addWidget(theGauge);
  // O. Mroz, Added Pie Chart top right corner, 4:30pm 29/03/2021 
  PieChart pieChart = new PieChart(3*SCREEN_X/4, NAVBAR_HEIGHT + MARGIN + 175, 115, 115, "Pie Chart", COLOR_SALMON, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, searchResult);
  screens[2].addWidget(pieChart);
  // B. Paisley, added Bar Chart top left Corner, 11:45am 30/03/2021
  BarChart barChart = new BarChart(MARGIN+40, SCREEN_Y/2 + 85, 500, 250, "Bar Chart", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, 1, 10000, searchResult);
  screens[2].addWidget(barChart);
  // S.Cataluna added Line Chart in bottom left corner, 5:23pm 31/03/2021
  lineChart = new LineChart((4*SCREEN_X/7)-10, SCREEN_Y/2 + 80, 500, 250, "Daily Change", COLOR_WHITE, COLOR_BLACK, robotoFont, true, EVENT_NULL, list, dateList, searchResult); 
  screens[2].addWidget(lineChart);
  // T. Moroney, Added logo to top of program for search and rankings page, 4:50pm 15/04/2021
  LogoClass logoClass = new LogoClass(-20, -20, 330, 150, "Logo", COLOR_SALMON, COLOR_BLACK, robotoFont, true, GO_TO_SEARCH_SCREEN, logoImage);
  screens[0].addWidget(logoClass);
  screens[1].addWidget(logoClass);
}

// O. Mroz, Added a function that refreshes the widgets with a new searchResult, 1:50pm 03/04/2021 
void refreshSearchResult(Screen screen, String searchResult) {
  ArrayList<Widget> widgetList = screen.widgetList;
  if (focus != null) // O. Mroz Added an if statement to check if focus exists - 1:25AM, 08/04/2021
    focus.label = "Search"; // S. Cataluna modified method to reset search bar when called - 9:17 7/04/2021 
  for (int i = 0; i < widgetList.size(); i++) {
    if (widgetList.get(i) instanceof BarChart) {
      BarChart bar = (BarChart)widgetList.get(i);
      bar.parent = searchResult;
      bar.processMap();
    } else if (widgetList.get(i) instanceof PieChart) {
      PieChart pie = (PieChart)widgetList.get(i);
      pie.setState(searchResult);
      pie.refreshData();
    } else if (widgetList.get(i) instanceof LineChart) { // S.Cataluna updated to refresh LineChart properly - 3:57pm 3/04/2021
      LineChart line = (LineChart)widgetList.get(i);
      line.setState(searchResult);
      line.calculateCases();
      Widget heading = widgetList.get(0); // S.Cataluna modified method to fix total cases bug 3:34pm 13/04/2021
      heading.label = "Results for: " + searchResult + "   |   Total Cases: " + line.combinedTotalCases; // S. Cataluna added display for total cases - quality of life for user - 4:30 12/04/2021
    } else if (widgetList.get(i) instanceof Gauge) {
      Gauge gauge = (Gauge)widgetList.get(i);
      gauge.setState(searchResult);
      gauge.refreshData();
    } //else if (widgetList.get(i).id == "resultHeading") {
    //Widget heading = widgetList.get(i);
    //heading.label = "Results for: " + searchResult + "   |   Total Cases: " + lineChart.combinedTotalCases; // S. Cataluna added display for total cases - quality of life for user - 4:30 12/04/2021
    //}
  }
}

void draw () {
  activeScreen.draw();
}

void mousePressed() {
  final String[] RANKING_BUTTON_IDS = {"high-to-low", "alphabetical", "test1", "test2"};
  int event;
  //TextSearch ts = screens[0].widgetList.get(3);
  for (int i = 0; i < activeScreen.widgetList.size(); i++) {
    Widget aWidget = (Widget) activeScreen.widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    if (event != TEXT_WIDGET && focus != null) { // S.Cataluna modified mousePressed to exit textSearch focus when clicked outside of it 10:21pm 13/04/2021
      focus.label = "Search";
      focus = null;
    }
    switch(event) {
    case GO_TO_SEARCH_SCREEN:
      activeScreen = screens[0];
      println("GO_TO_SEARCH_SCREEN event triggered.");
      on = true;  // S. Cataluna added on boolean for demonstration functionality (temporary) - 1:00pm 23/03/2021
      break;
    case GO_TO_RANKING_SCREEN:
      activeScreen = screens[1];
      println("GO_TO_RANKING_SCREEN event triggered.");
      break;
    case GO_TO_RESULT_SCREEN:
      activeScreen = screens[2];
      println("GO_TO_RESULT_SCREEN event triggered.");
      break;
    case TEXT_WIDGET:
      println("clicked on a text widget!");
      focus = (TextSearch) aWidget;
      // S. Cataluna added QoL improvements to search bar 3:05pm 10/04/2021
      if (focus.label.equals("Search") || (focus.label.equals("Please enter a valid state"))) {
        focus.label = ("");
      }
      int k = focus.mousePressed();//B.Paisley added a method for selecting a dropdown, 13:37pm 06/04/2021
      if (k==1) {
        searchResult = focus.getText();
        refreshSearchResult(screens[2], searchResult);
        activeScreen = screens[2];
      }
      return;
    case SCROLL_BAR:
      println("Clicked on ScrollBar");//B. Paisley addedcase to test scrollbar, 21:53 08/04/2021
      //ScrollBar sb = (ScrollBar) aWidget;
      //RankedList rl = (RankedList) activeScreen.widgetList.get(i+1);
      //float pos = sb.getScroll();
      //rl.move(pos);
      break;
    case 200000000: //B. Paisley added temporary case event for swapping order of ranked list, 15:45 15/04/2021
      // O. Mroz, Implemented a solution which locates the ranked list by checking the class instance, 3:00pm 19/04/2021 
      RankedList rl = null;
      for (int j = 0; j < activeScreen.widgetList.size(); j++) {
        Widget widget = activeScreen.widgetList.get(j);
        if (widget instanceof RankedList) {
          RankedList myRl = (RankedList)widget;
          rl = myRl;
        }
        if(Arrays.asList(RANKING_BUTTON_IDS).contains(widget.id)){
          widget.setColor(COLOR_FREESIA);
        }
        if (widget.id == "high-to-low") widget.setColor(COLOR_SALMON);
      }
      if (rl != null) rl.changeOrder(200000000);
      break;
    case 200000001: //B. Paisley added temporary case event for swapping order of ranked list, 15:45 15/04/2021
      // O. Mroz, Implemented a solution which locates the ranked list by checking the class instance, 3:00pm 19/04/2021 
      RankedList rl2 = null;
      for (int j = 0; j < activeScreen.widgetList.size(); j++) {
        Widget widget = activeScreen.widgetList.get(j);
        if (widget instanceof RankedList) {
          RankedList myRl = (RankedList)widget;
          rl2 = myRl;
        }
        if(Arrays.asList(RANKING_BUTTON_IDS).contains(widget.id)){
          widget.setColor(COLOR_FREESIA);
        }
        if (widget.id == "alphabetical") widget.setColor(COLOR_SALMON);
      }
      if (rl2 != null) rl2.changeOrder(2000000001);
      break;
    case 200000002:
      // O. Mroz, Implemented a solution which locates the ranked list by checking the class instance, 3:00pm 19/04/2021 
      RankedList rl3 = null;
      DateSlider ds = null;//B. Paisley added functionality for the date slider, 21:30 19/04/2021
      String[] dates = null;
      for (int j = 0; j < activeScreen.widgetList.size(); j++) {
        Widget widget = activeScreen.widgetList.get(j);
        if (widget instanceof RankedList) {
          RankedList myRl = (RankedList)widget;
          rl3 = myRl;
        }
        if (widget instanceof DateSlider){
          DateSlider myDs = (DateSlider)widget;
          ds = myDs;
        }
        if(Arrays.asList(RANKING_BUTTON_IDS).contains(widget.id)){
          widget.setColor(COLOR_FREESIA);
        }
        if (widget.id == "test1") widget.setColor(COLOR_SALMON);
      }
      if (ds != null){
        dates = ds.getDates();
      }
      if (rl3 != null&&dates!=null) rl3.undisclosed2(dates[0], dates[1]);
      break;
    case 200000003:
      // O. Mroz, Implemented a solution which locates the ranked list by checking the class instance, 3:00pm 19/04/2021 
      RankedList rl4 = null;
      for (int j = 0; j < activeScreen.widgetList.size(); j++) {
        Widget widget = activeScreen.widgetList.get(j);
        if (widget instanceof RankedList) {
          RankedList myRl = (RankedList)widget;
          rl4 = myRl;
        }
        if(Arrays.asList(RANKING_BUTTON_IDS).contains(widget.id)){
          widget.setColor(COLOR_FREESIA);
        }
        if (widget.id == "test2") widget.setColor(COLOR_SALMON);
      }
      if (rl4 != null) rl4.undisclosed2("01/04/2020", "02/07/2020");
      break;
    case SEARCH_ALABAMA:
      activeScreen = screens[2];
      searchResult = "Alabama";
      refreshSearchResult(screens[2], searchResult);
      println("SEARCH_ALABAMA event triggered.");
      break;
    case SEARCH_ALASKA:
      activeScreen = screens[2];
      searchResult = "Alaska";
      refreshSearchResult(screens[2], searchResult);
      println("SEARCH_ALASKA event triggered.");
      break;
    case SEARCH_ARIZONA:
      activeScreen = screens[2];
      searchResult = "Arizona";
      println("SEARCH_ARIZONA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_ARKANSAS:
      activeScreen = screens[2];
      searchResult = "Arkansas";
      println("SEARCH_ARKANSAS event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_CALIFORNIA:
      activeScreen = screens[2];
      searchResult = "California";
      println("SEARCH_CALIFORNIA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_COLORADO:
      activeScreen = screens[2];
      searchResult = "Colorado";
      println("SEARCH_COLORADO event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_CONNECTICUT:
      activeScreen = screens[2];
      searchResult = "Connecticut";
      println("SEARCH_CONNECTICUT event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_DELAWARE:
      activeScreen = screens[2];
      searchResult = "Delaware";
      println("SEARCH_DELAWARE event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_FLORIDA:
      activeScreen = screens[2];
      searchResult = "Florida";
      println("SEARCH_FLORIDA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_GEORGIA:
      activeScreen = screens[2];
      searchResult = "Georgia";
      println("SEARCH_GEORGIA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_HAWAII:
      activeScreen = screens[2];
      searchResult = "Hawaii";
      println("SEARCH_HAWAII event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_IDAHO:
      activeScreen = screens[2];
      searchResult = "Idaho";
      println("SEARCH_IDAHO event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_ILLINOIS:
      activeScreen = screens[2];
      searchResult = "Illinois";
      println("SEARCH_ILLINOIS event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_INDIANA:
      activeScreen = screens[2];
      searchResult = "Indiana";
      println("SEARCH_INDIANA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_IOWA:
      activeScreen = screens[2];
      searchResult = "Iowa";
      println("SEARCH_IOWA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_KANSAS:
      activeScreen = screens[2];
      searchResult = "Kansas";
      println("SEARCH_KANSAS event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_KENTUCKY:
      activeScreen = screens[2];
      searchResult = "Kentucky";
      println("SEARCH_KENTUCKY event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_LOUISIANA:
      activeScreen = screens[2];
      searchResult = "Louisiana";
      println("SEARCH_LOUISIANA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MAINE:
      activeScreen = screens[2];
      searchResult = "Maine";
      println("SEARCH_MAINE event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MARYLAND:
      activeScreen = screens[2];
      searchResult = "Maryland";
      println("SEARCH_MARYLAND event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MASSACHUSETTS:
      activeScreen = screens[2];
      searchResult = "Massachusetts";
      println("SEARCH_MASSACHUSETTS event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MICHIGAN:
      activeScreen = screens[2];
      searchResult = "Michigan";
      println("SEARCH_MICHIGAN event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MINNESOTA:
      activeScreen = screens[2];
      searchResult = "Minnesota";
      println("SEARCH_MINNESOTA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MISSISSIPPI:
      activeScreen = screens[2];
      searchResult = "Mississippi";
      println("SEARCH_MISSISSIPPI event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MISSOURI:
      activeScreen = screens[2];
      searchResult = "Missouri";
      println("SEARCH_MISSOURI event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_MONTANA:
      activeScreen = screens[2];
      searchResult = "Montana";
      println("SEARCH_MONTANA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEBRASKA:
      activeScreen = screens[2];
      searchResult = "Nebraska";
      println("SEARCH_NEBRASKA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEVADA:
      activeScreen = screens[2];
      searchResult = "Nevada";
      println("SEARCH_NEVADA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEW_HAMPSHIRE:
      activeScreen = screens[2];
      searchResult = "New Hampshire";
      println("SEARCH_NEW_HAMPSHIRE event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEW_JERSEY:
      activeScreen = screens[2];
      searchResult = "New Jersey";
      println("SEARCH_NEW_JERSEY event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEW_MEXICO:
      activeScreen = screens[2];
      searchResult = "New Mexico";
      println("SEARCH_NEW_MEXICO event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NEW_YORK:
      activeScreen = screens[2];
      searchResult = "New York";
      println("SEARCH_NEW_YORK event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NORTH_CAROLINA:
      activeScreen = screens[2];
      searchResult = "North Carolina";
      println("SEARCH_NORTH_CAROLINA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_NORTH_DAKOTA:
      activeScreen = screens[2];
      searchResult = "North Dakota";
      println("SEARCH_NORTH_DAKOTA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_OHIO:
      activeScreen = screens[2];
      searchResult = "Ohio";
      println("SEARCH_OHIO event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_OKLAHOMA:
      activeScreen = screens[2];
      searchResult = "Oklahoma";
      println("SEARCH_OKLAHOMA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_OREGON:
      activeScreen = screens[2];
      searchResult = "Oregon";
      println("SEARCH_OREGON event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_PENNSYLVANIA:
      activeScreen = screens[2];
      searchResult = "Pennsylvania";
      println("SEARCH_PENNSYLVANIA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_RHODE_ISLAND:
      activeScreen = screens[2];
      searchResult = "Rhode Island";
      println("SEARCH_RHODE_ISLAND event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_SOUTH_CAROLINA:
      activeScreen = screens[2];
      searchResult = "South Carolina";
      println("SEARCH_SOUTH_CAROLINA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_SOUTH_DAKOTA:
      activeScreen = screens[2];
      searchResult = "South Dakota";
      println("SEARCH_SOUTH_DAKOTA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_TENNESSEE:
      activeScreen = screens[2];
      searchResult = "Tennessee";
      println("SEARCH_TENNESSEE event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_TEXAS:
      activeScreen = screens[2];
      searchResult = "Texas";
      println("SEARCH_TEXAS event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_UTAH:
      activeScreen = screens[2];
      searchResult = "Utah";
      println("SEARCH_UTAH event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_VERMONT:
      activeScreen = screens[2];
      searchResult = "Vermont";
      println("SEARCH_VERMONT event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_VIRGINIA:
      activeScreen = screens[2];
      searchResult = "Virginia";
      println("SEARCH_VIRGINIA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_WASHINGTON:
      activeScreen = screens[2];
      searchResult = "Washington";
      println("SEARCH_WASHINGTON event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_WEST_VIRGINIA:
      activeScreen = screens[2];
      searchResult = "West Virginia";
      println("SEARCH_WEST_VIRGINIA event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_WISCONSIN:
      activeScreen = screens[2];
      searchResult = "Wisconsin";
      println("SEARCH_WISCONSIN event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    case SEARCH_WYOMING:
      activeScreen = screens[2];
      searchResult = "Wyoming";
      println("SEARCH_WYOMING event triggered.");
      refreshSearchResult(screens[2], searchResult);
      break;
    default:
      break;
    }
  }
}

void keyPressed() { // S Cataluna Updated keyPressed to update searchResult 3:56pm 3/04/2021
  if (activeScreen == screens[0]) 
  {
    if (focus !=null && keyCode != SHIFT && keyCode != CONTROL && keyCode != TAB && keyCode!= DELETE && keyCode != 20) {
      focus.append(key);
      searchResult = focus.getText();
    }
    if (keyCode == ENTER || keyCode == RETURN) { // S. Cataluna added error handling - 9:17pm 7/04/2021
      boolean adr = false;// B. Paisley updated error handling 16:32pm 08/04/2021
      for (String k : focus.atlas.keySet()) {
        if (k.toLowerCase().equals(searchResult.replace("\n", "").toLowerCase())) {
          searchResult = k;
          adr = true;
          break;
        }
      }
      if (adr) {
        refreshSearchResult(screens[2], searchResult.replace("\n", ""));
        activeScreen = screens[2];
        adr = false;
      } else {
        focus.label = "Please enter a valid state";
      }
      if (focus.atlas.containsKey(searchResult.replace("\n", "").toLowerCase())) {
        refreshSearchResult(screens[2], searchResult.replace("\n", ""));
        activeScreen = screens[2];
      } else {
        focus.label = "Please enter a valid state";
      }
    }
  }
}
void mouseWheel(MouseEvent event) { // B. Paisley added scroll function, 22:05 08/04/2021
  if (activeScreen == screens[1]) {
    int move = event.getCount();
    // O. Mroz, Implemented a solution which locates the ranked list and scrollbar by checking the class instance, 3:00pm 19/04/2021 
    ScrollBar sb = null;
    RankedList rl = null;
    for (int j = 0; j < activeScreen.widgetList.size(); j++) {
      if (activeScreen.widgetList.get(j) instanceof ScrollBar) {
        ScrollBar mySb = (ScrollBar)activeScreen.widgetList.get(j);
        sb = mySb;
      }
      if (activeScreen.widgetList.get(j) instanceof RankedList) {
        RankedList myRl = (RankedList)activeScreen.widgetList.get(j);
        rl = myRl;
      }
    }
    if (sb!=null && rl != null) {
      sb.tmove(move);
      float pos = sb.getScroll();
      rl.move(pos);
    }
    //sb.move(move);
  }
}
void mouseDragged() {//B. Paisley added mouseDragged for the scrollBar, 19:47 10/04/21
  // O. Mroz, Implemented a solution which locates the ranked list and scrollbar by checking the class instance, 3:00pm 19/04/2021 
  ScrollBar sb = null;
  RankedList rl = null;
  for (int j = 0; j < activeScreen.widgetList.size(); j++) {
    if (activeScreen.widgetList.get(j) instanceof ScrollBar) {
      ScrollBar mySb = (ScrollBar)activeScreen.widgetList.get(j);
      sb = mySb;
    }
    if (activeScreen.widgetList.get(j) instanceof RankedList) {
      RankedList myRl = (RankedList)activeScreen.widgetList.get(j);
      rl = myRl;
    }
  }
  if (sb!=null && rl != null) {
     float pos = sb.getScroll();
     rl.move(pos);
  }
}
