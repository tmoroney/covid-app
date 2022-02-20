// S. Cataluna added state class 6:30pm 1/04/2021
class State {
  String state;
  String[] stateLetters;
  
  State(String enteredState) {
    state = enteredState;
    stateLetters = state.split("");
  }
}
