import java.util.*;//B. Paisley added a subclass of widget for the user to select the dates they want to examine, 20:00 15/04/2021
public class DateSlider extends Widget{
  ArrayList<DataLine> data;
  ArrayList<String> allDates;
  ArrayList<String> tempDates2;
  HashMap<String, Integer> tempDates;
  float firstTabX,lastTabX,startX, endX, lineY,newX1,newX2;
  int slideWidth;
  boolean locked1,over1,locked2,over2;
  DateSlider(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, ArrayList<DataLine> data){
    super(x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    this.data = data;
    firstTabX = x;
    startX =  x;
    newX1 = x;
    lastTabX = x+width;
    endX = x+width;
    newX2 = x+width;
    lineY = y;
    slideWidth = 10;
    allDates = new ArrayList<String>();
    tempDates2 = new ArrayList<String>();
    tempDates = new HashMap<String, Integer>();
    setDateList();
  }
  void setDateList(){//B. Paisley added a method to get all of the dates in order, 20:00 15/04/2021
    for(int i = 1; i < data.size();i++){
      allDates.add(data.get(i).date);
    }
    Set<String> set = new LinkedHashSet<String>();
    set.addAll(allDates); //<>// //<>// //<>//
    allDates = new ArrayList<String>();
    allDates.addAll(set); //<>// //<>// //<>//
  } //<>// //<>// //<>// //<>//
  void draw(){
    update1();
    update2();
    drawBar();
    drawSliders();
    drawDates();
  }
  void drawBar(){
    fill(0);
    stroke(3);
    line(startX, y, endX, y); //<>// //<>// //<>//
    noStroke();
  }
  void drawSliders(){
    if (over1 || locked1){
      fill(0);
    } else { 
      fill(120);
    }
    rect(firstTabX-(slideWidth/2), y-(height/2), slideWidth, height);
    if (over2 || locked2){
      fill(0);
    } else { 
      fill(120);
    }
    rect(lastTabX-(slideWidth/2), y-(height/2), slideWidth, height);
  }
  void check1(){//B. Paisley updated checks to get smaller sets of dates, 21:30 19/04/2021
    if (lastTabX-newX1<= 5){
      newX1=lastTabX-6;
    }
    if (lastTabX<firstTabX){
      lastTabX = firstTabX+1;
    }
  }
  void check2(){
    if(newX2-firstTabX <= 5){
      newX2=6 + firstTabX;
    }
    if (firstTabX > lastTabX){
      firstTabX = lastTabX-1;
    }
  }
  String[] getDates(){// B.Paisley added a method to find and return the strings the user selected, 20:00 15/04/2021
    float posA = (firstTabX - startX)/width;
    float posB = (lastTabX - startX)/width;
    float size = allDates.size() - 1;
    posA = posA * size;
    posB = posB * size;
    String sA = allDates.get(int(posA));
    String sB = allDates.get(int(posB));
    String[] list = {sA,sB};
    return list;
  }
  boolean overEvent1(){
    if(mouseX>=firstTabX-slideWidth/2&&mouseX<=firstTabX+slideWidth/2&&mouseY>=y-(height/2)&&mouseY<=y+(height/2)){
      return true;
    }
    return false;
  }
  boolean overEvent2(){
    if(mouseX>=lastTabX-slideWidth/2&&mouseX<=lastTabX+slideWidth/2&&mouseY>=y-(height/2)&&mouseY<=y+(height/2)){
      return true;
    }
    return false;
  }
  void update1(){
    if(overEvent1()){
      over1 = true;
    } else {
      over1 = false;
    }
    if (mousePressed && over1 && !locked2){
      locked1 = true;
    }
    if (!mousePressed){
      locked1 = false;
    }
    if (locked1){
      newX1 = constrain(mouseX-slideWidth/2, startX, endX);
      check1();
    }
    if (abs(newX1 - firstTabX) > 1){
      firstTabX = int(firstTabX + (newX1-firstTabX)/1);
    }
  }
  void update2(){
    if(overEvent2()){
      over2 = true;
    } else {
      over2 = false;
    }
    if (mousePressed && over2 && !locked1){
      locked2 = true;
    }
    if (!mousePressed){
      locked2 = false;
    }
    if (locked2){
      newX2 = constrain(mouseX-slideWidth/2, startX, endX);
      check2();
    }
    if (abs(newX2 - lastTabX) > 1){
      lastTabX = int(lastTabX + (newX2-lastTabX)/1);
    }
  }
  float constrain(float val, float minHeight, float maxHeight){
    return min(max(val, minHeight), maxHeight);
  }
  void drawDates(){
    String[] s = getDates();
    fill(0);
    textAlign(LEFT,BOTTOM);
    text(s[0],startX,y-height/2);
    textAlign(RIGHT,BOTTOM);
    text(s[1],endX,y-height/2);
  }
}
