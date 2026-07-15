class NumberLock {

  boolean unlocked;

  int digit;
  int[] answer;
  int[] number;

  Furniture target;

  NumberLock() {
    unlocked = false;
  }

  void open(Furniture target, int digit, int[] ans) {

    this.target = target;
    this.digit = digit;
    this.answer = ans;

    unlocked = false;

    number = new int[digit];

    for (int i=0; i<digit; i++) {
      number[i] = 0;
    }
  }

  void display() {

    fill(0, 150);
    rect(0, 0, width, height);

    fill(240);
    rect(150, 100, 500, 250);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(36);
    text("NUMBER LOCK", 400, 140);

    int startX = width/2 - (digit*70-20)/2;

    for (int i=0; i<digit; i++) {

      int x = startX + i*70;

      fill(255);
      stroke(0);
      rect(x, 220, 50, 50);

      fill(0);
      text(number[i], x+25, 245);
    }

    fill(255);
    rect(580, 120, 40, 40);

    fill(0);
    text("×", 600, 140);

    noStroke();
  }

  void mousePressed() {

    if (mouseX>=580 && mouseX<=620 &&
      mouseY>=120 && mouseY<=160) {

      GameState = ROOM;
      return;
    }

    int startX = width/2 - (digit*70-20)/2;

    for (int i=0; i<digit; i++) {

      int x = startX + i*70;

      if (mouseX>x &&
        mouseX<x+50 &&
        mouseY>220 &&
        mouseY<270) {

        number[i]++;

        if (number[i] > 9) {
          number[i] = 0;
        }

        check();
      }
    }
  }

  void check() {

    for (int i=0; i<digit; i++) {

      if (number[i] != answer[i]) {
        return;
      }
    }

    println("open");

    unlocked = true;

    if (target != null) {
      target.unlock();
    }

    GameState = ROOM;
  }
}
