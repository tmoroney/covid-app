// S. Cataluna added DataLine class, and its methods - 7:52pm 2021
class DataLine {
  String date;
  String area;
  String state;
  int geoID;
  int cases;
  String country;

  DataLine(String newDate, String newArea, String newState, int newGeoID, int newCases, String newCountry) {
    date = newDate;
    area = newArea;
    state = newState;
    geoID = newGeoID;
    cases = newCases;
    country = newCountry;
  } // DataLine object contains all components that make up one line of data in csv

  String toString() {
    return "Date: " + date + ", Area: " + area + ", State/County: " + state + ", geo ID: " 
      + geoID + ", Cases: " + cases + ", Country: " + country;
  } // used for printing
}
