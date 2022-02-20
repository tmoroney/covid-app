// O. Mroz, Added TextSearch subclass of Widget template, 3:30pm 22/03/2021 //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
// S. Cataluna updated TextSearch to take in the users keystrokes 5:25pm 1/04/2021
class TextSearch extends Widget {
  String[] SearchableElements;
  ArrayList<String> matches;
  ArrayList<DataLine> data;
  HashMap<String, Integer> atlas;
  int maxlen;
  float xpos;
  int timer;
  int textBoxHeight;
  int autoFillHeight;
  
  TextSearch(int x, int y, int width, int height, String label, color widgetColor, color labelColor, PFont widgetFont, boolean borderShown, int event, int maxlen, ArrayList<DataLine> data) {
    super (x, y, width, height, label, widgetColor, labelColor, widgetFont, borderShown, event);
    super.hoverEffect = false;
    this.maxlen = maxlen;
    matches = new ArrayList<String>();
    atlas = new HashMap<String, Integer>();
    this.data = data;
    int count = 0; //B. Paisley added a sorting method for the states, 19:00pm 03/04/2021
    for (DataLine entry : data) {
      if (count > 0) {
        atlas.put(entry.state, entry.cases);
      }
      count++;
    }
    textBoxHeight = height;// B. Paisley added a new variable to prevent bugs, 13:37pm 06/04/2021
    autoFillHeight = height;// O. Mroz added a new variable to preven bugs :), 5:00PM 15/04/2021
  }
  String getText() {
    return label;
  }
  void append(char s) {
    if (s==BACKSPACE) {
      if (!label.equals("")) {
        label=label.substring(0, label.length()-1);
        if (label.length()==1) {
          xpos = xpos - (textWidth(label.charAt(label.length()-1))-3);
        } else if (label.length() > 1) {
          xpos = xpos - (textWidth(label.charAt(label.length()-1)));
        }
      }
    } else if (label.length() < maxlen) {
      label=label+str(s);
      findMatches();
        xpos = xpos + textWidth(s);
    }
  }
  // B. Paisley added a method to find the appropriate states for the dropdown, 19:00pm 03/04/2021
  void findMatches() {
    if (matches!=null) {
      matches.clear();
    }
    for (String s : atlas.keySet()) {
      if (s.toLowerCase().startsWith(label.toLowerCase())) {
        matches.add(s);
      }
      this.height = textBoxHeight + (autoFillHeight*matches.size());
    }
  }
  // B. Paisley added a draw method for the dropdown, 19:00pm 03/04/2021
  void drawMatches() {
    int y = this.y+textBoxHeight-(textBoxHeight*2/5);
    if (matches!=null) {
      int totalSpaces = matches.size();
      fill(COLOR_WHITE);
      stroke(COLOR_DARKER_GREY);
      rect(x, this.y, width, textBoxHeight + (autoFillHeight*totalSpaces) + (totalSpaces>0?15:0), 6);
      noStroke();
      int space = 1;
      for (String match : matches) {
        fill(COLOR_BLACK);
        textAlign(LEFT, CENTER);
        text(match, x+10, y+autoFillHeight*space);
        space++;
      }
    }
  }
  // B. Paisley added a draw method for search, 19:00pm 03/04/2021
  void draw() {
    drawMatches();
    timer++;
    fill(widgetColor);
    stroke(COLOR_DARKER_GREY);
    rect(x, y, width, textBoxHeight, 6);
    noStroke();
    fill(labelColor);
    textAlign(LEFT, CENTER);
    text(label, x+10, y+(textBoxHeight/2)-2);
    // S. Cataluna added flashing bar to search bar (QoL improvement) - 3:05pm 10/04/2021
    if (label.equals("")) {
      xpos = 0;
    }
    if (!label.equals("Search") && timer < autoFillHeight && !label.equals("Please enter a valid state")) {
      fill(0);
      rect(x + xpos + 10, y+(textBoxHeight/2) - 11, 1, 24);
    }
    if (timer == 100) {
      timer = 0;
    }
    // O. Mroz, Added cursor hover effects, 3:00pm 16/04/2021 
    if (mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      cursor(TEXT);
      cursor = true;
    }
    if (cursor && (mouseX < x || mouseX > x+width || mouseY < y || mouseY > y+textBoxHeight)) {
      cursor  = false;
      cursor(ARROW);
    }
  }

  int mousePressed() {//B. Paisley added a method for checking if a dropdown was selected, 13:37pm 06/04/2021
    int y = this.y+textBoxHeight;
    int k = 0;
    if (matches!=null) {
      int space = 0;
      for (String match : matches) {
        if (mouseX >= x && mouseX <= x+width && 
            mouseY >= y+(50*space) && mouseY <= y+(autoFillHeight*(space+1))) {
          label = match;
          matches.clear();
          k = 1;
          break;
        }
        space++;
      }
    }
    return k;
  }
}
