int GameState = 0;

final int START = 0;
final int ROOM = 1;
final int PUZZLE = 2;
final int CLEAR = 3;

Player player;
Room room;
Item item;
Puzzle puzzle;

PImage bgStart;
PImage bgRoom;
PImage bgClear;

void setup() {
  size(1280, 720);
  player = new Player();
  room = new Room();
  item = new Item();
  puzzle = new Puzzle();
}

void draw() {

  background(255);

  switch(GameState) {

  case START:
    // if(bgStart != null) image(bgStart,0,0,width,height);
    break;

  case ROOM:
    // if(bgRoom != null) image(bgRoom,0,0,width,height);
    room.display();
    item.display();
    player.display();
    break;

  case PUZZLE:
    puzzle.display();
    break;

  case CLEAR:
    // if(bgClear != null) image(bgClear,0,0,width,height);
    break;
  }
}

void mousePressed() {

  switch(GameState) {

  case START:
    GameState = ROOM;
    break;

  case ROOM:
    room.mousePressed();
    item.mousePressed();
    player.mousePressed();
    break;

  case PUZZLE:
    puzzle.mousePressed();
    break;

  case CLEAR:
    break;
  }
}
