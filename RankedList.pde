public class RankedList extends Widget{// B,Paisley added the Rankings class, 15:40 10/04/21
  ArrayList<DataLine> data;
  ArrayList<Date> dateList;
  HashMap<String,Integer> tempAtlas;
  HashMap<String,Integer> tempDates;
  HashMap<String,Integer> refList;
  ArrayList<String> allStates;
  ArrayList<String> allDates;
  ArrayList<Integer> worstCase;
  ArrayList<String> sortedList;
  float listHeight = 0;
  int start;
  float listY;
  int bottomPadding;
  int topPadding;
  int boxHeight = 70;
  String order, firstDate, lastDate;
  RankedList(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data){
    super(x,y,width,height,label,widgetColor,labelColor,widgetFont,borderShown,event);
    this.data = data;
    bottomPadding = SCREEN_Y-y-height;
    topPadding = y-2;
    start = y;
    listY = y;
    tempAtlas = new HashMap<String,Integer>();
    tempDates = new HashMap<String,Integer>();
    refList = new HashMap<String,Integer>();
    allStates = new ArrayList<String>();
    allDates = new ArrayList<String>();
    worstCase = new ArrayList<Integer>();
    sortedList = new ArrayList<String>();
    order = "Alphabetical";// B. Paisley added a sorting filter, 23:10 14/04/2021
    firstDate = "25/12/2020"; //B. Paisley added text for formatting results, 15:45 15/04/2021
    lastDate = "31/12/2020";
    findStates();
    //findCases();
    undisclosed1(); // B. Paisley added a method finding the indexes of when all dates begin in the dataset, 23:10 14/04/2021
    undisclosed2(firstDate, lastDate);// B. Paisley added a faster method for finding queries, 23:10 14/04/2021
  }
  void findStates(){// B. Paisley added a function to find individual states and dates, 15:40 10/04/21
    int count = 0;
    for(DataLine entry : data){
      if(count > 0){
        tempAtlas.put(entry.state, entry.cases);
        tempDates.put(entry.date, entry.cases);
      }
      count++;
    }
    for(String s : tempAtlas.keySet()){
      allStates.add(s);
      sortedList.add(s);
    }
    java.util.Collections.sort(sortedList);
    //for(String s : tempDates.keySet()){
    //  allDates.add(s);
    //}
  }
  void findCases(){ //B. Paisley added a function to find the highest figure from the last seven days, 15:40 10/04/21
    for(String s : allStates){
      int count = 0;
      int highest = 0;
      String pastDate = "";
      Inner:
      for(int i = allDates.size() - 1; i > 0; i--){
        for(int j = data.size() - 1; j > 0; j--){
          if(data.get(j).date.equals(allDates.get(i)) && data.get(j).state.equals(s)){
            int num = data.get(j).cases;
            if(!pastDate.equals(allDates.get(i))){
              count++;
              pastDate=allDates.get(i);
            }
            if(num > highest){
              highest = num;
            }
          }
          if(count>=7){
            break Inner;
          }
        }
      }
      worstCase.add(highest);
    }
  }
  
  void draw(){ // T. Moroney, Added mask to the top and bottom of the list to hide overflow, 6:30pm 14/04/2021
    drawRankings();
    fill(COLOR_BABY_BLUE);
    rect(x-10, 0, width+20, topPadding);
    rect(x-10, y+height, width+20, bottomPadding);
  }
  //B. Paisley cleaned up text output, 15:45 15/04/2021
  void drawRankings(){//B.Paisley implemented a drawinng and sorting method for the rankings, 15:40 10/04/21
    int tempX = x;
    float tempY = listY;
    if(order.equals("HighLow")){ //<>//
      int pastHigh = 1999999999;
      int currentHigh = 0;
      int highIndex = 0;
      for(int i = 0; i < allStates.size(); i++){ //<>//
        int count = 0;
        for(int g : worstCase){
          if(g < pastHigh && g > currentHigh){ //<>//
            currentHigh = g;
            highIndex = count;
          }
          count++;
        }
        fill(COLOR_WHITE);
        strokeWeight(2);
        stroke(COLOR_DARKER_GREY);
        rect(tempX, tempY, width, boxHeight, 6);
        noStroke();
        fill(0);
        textAlign(LEFT,CENTER);
        textSize(20);
        text(allStates.get(highIndex),tempX+20, tempY+20);
        textSize(14);
        text(formatter.format(worstCase.get(highIndex)) + " cases reported between " + firstDate + " and " + lastDate + ".", tempX + 20, tempY + 50); // S. Cataluna formatted case totals 9:47pm 12/04/2021
        tempY = tempY + boxHeight + 5;
        listHeight = tempY + boxHeight + 5;
        pastHigh = currentHigh;
        currentHigh = 0;
        highIndex = 0;
      }
    }
    else if(order.equals("Alphabetical")){
      for(String state : sortedList){
        fill(COLOR_WHITE);
        strokeWeight(2);
        stroke(COLOR_DARKER_GREY);
        rect(tempX, tempY, width, boxHeight, 6);
        noStroke();
        fill(0);
        textAlign(LEFT,CENTER);
        textSize(20);
        text(state,tempX+20, tempY+20);
        textSize(14);
        text(formatter.format(refList.get(state)) + " cases reported between " + firstDate + " and " + lastDate + ".", tempX + 20, tempY + 50); // S. Cataluna formatted case totals 9:47pm 12/04/2021
        tempY = tempY + boxHeight + 5;
      }
    }
  }
  void move(float event){// B. Paisley added Scrolling functionality for list, 19:47 10/04/21
     listY = start - (event * 3570);// B. Paisley updated value for length of list, 17:36 12/04/2021, And again on 21:34 19/04/2021
  }
  void undisclosed1(){// B. Paisley added a method finding when all dates begin in the dataset, 23:10 14/04/2021
    for(int index = data.size()-1;index>=0;index--){
      tempDates.put(data.get(index).date,index);
    }
  }
  void undisclosed2(String start, String end){ //B. Paisley added a method finding appropriate values between the dtaes needed, 23:10 14/04/2021
    if(worstCase != null) {
      worstCase.clear();
    }
    firstDate = start; //B. Paisley updated method to change dates on screen, 15:50 15/04/2021
    lastDate = end;
    int startIndex = tempDates.get(start);
    int endIndex = tempDates.get(end);
    String[] splitString = start.split("/");
    int dayA = Integer.parseInt(splitString[0]);
    int monthA = Integer.parseInt(splitString[1]);
    int yearA = Integer.parseInt(splitString[2]);
    splitString = end.split("/");
    int dayB = Integer.parseInt(splitString[0]);
    int monthB = Integer.parseInt(splitString[1]);
    int yearB = Integer.parseInt(splitString[2]);
    for(String state : allStates){
      int endTotal = 0;
      int total = 0;
      String prevDate = start;
      for(int i = startIndex; i < endIndex; i++){
        String date = data.get(i).date;
        splitString = date.split("/");
        int dayC = Integer.parseInt(splitString[0]);
        int monthC = Integer.parseInt(splitString[1]);
        int yearC = Integer.parseInt(splitString[2]);
        if(((dayC>=dayA||monthC>=monthA)&&(yearC>=yearA))&&
          ((dayC<=dayB||monthC<=monthB)&&yearC<=yearB)&&
          (state.equals(data.get(i).state))&&(prevDate.equals(date))){
            total+=data.get(i).cases;
        }
        else if(!date.equals(prevDate)){
          total = 0;
          prevDate = date;
        }
        if(total>endTotal){
          endTotal = total;
        }
      }
      worstCase.add(endTotal);
      refList.put(state, endTotal);
    }
  }
  void changeOrder(int event){//B. Paisley added a method changing how the list gets sorted, 23:10 14/04/2021
    if (event==200000000){
      order = "HighLow";
    }
    else if(event==2000000001){
      order = "Alphabetical";
    }
  }
}
