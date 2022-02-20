class Present { //B. Paisley added the Present class and methods, added 16:45 23/03/2021
  ArrayList<DataLine> data;
  //O. Mroz fixed syntax error, 11:10 23/03/2021
  ArrayList<String> states;
  ArrayList<Integer> totalCases;
  float x, y, width, height, unitWidth, unitHeight;
  Present(ArrayList<DataLine> data, float x, float y, float width, float height){
    this.data = data;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    // O. Mroz moved new object assignment to constructor, 11:10 23/03/2021
    states = new ArrayList<String>();
    totalCases = new ArrayList<Integer>();
    processStates();
    processTotal();
  }
  
  void draw(){
    fill(200);
    rect(x,y,width,height);
    drawBars();
  }
  
  //creates an array list containing all the states
  //B. Paisley updated method fixing various bugs, 02:40 24/03/2021
  void processStates() {
    int top = 0;
    boolean add = true;
    // B. Paisley fixed an error allowing null lists to be read, 02:40 24/03/2021
    if (data!=null) {
      for (DataLine entry : data) {
        int i = data.indexOf(entry);
        if (i > 0 && top < 10000) {
          if (states == null) {
            states.add(entry.state);
          }
          else{
            add = true;
            for (String state : states) {
              if (state.equalsIgnoreCase(entry.state)) {
                add = false;
              }
            }
            if (add) {
              states.add(entry.state);
            }
          }
          top++;
          if (top >= 10000) {
            break;
          }
        }
      }
    }
    unitWidth = width/states.size();
  }
  
  //creates an array list containing the total cases in the corresponding state
  //B. Paisley updated method fixing various bugs, 02:40 24/03/2021
  void processTotal() {
    for(String state : states){
      int total = 0;
      int top = 0;
      inner:
      for(DataLine entry : data){
        top++;
        if(top>=10000){
          break inner;
        }
        if(state.equalsIgnoreCase(entry.state)){
          total += entry.cases;
        }
      }
      totalCases.add(total);
    }
    float highest = 0; //<>// //<>// //<>//
    for(int total : totalCases){
      if(total > highest){
        highest = total;
      }
    }
    unitHeight = height/highest;
  }
  
  //draws all the bars for the graph
  //B. Paisley cleaned method for ease of reading, 02:40 24/03/2021
  void drawBars(){
    for(int total : totalCases){
      int i = totalCases.indexOf(total);
      fill(0, 0, 250);
      rect(x + (unitWidth * i), height - (unitHeight * total), unitWidth, (unitHeight * total));
    }
  }
}
