//=================================
// App.pde 前半①
//=================================

//---------- GameState ----------
final int ROOM = 0;
final int BOOK = 1;
final int PAINTING = 2;
final int CLEAR = 3;

int GameState = ROOM;

//---------- 画像 ----------
PImage room1;
PImage room2;

PImage book1;
PImage book2;

PImage painting1;
PImage painting2;

int paintingSelect = 0;

//---------- システム ----------
Inventory inventory;
NumberLock numberLock;
MessageBox msg;
PaperPuzzle paperPuzzle;

//---------- 家具 ----------
Funiture book;
Funiture drawer;
Funiture safe;
Funiture sofa;
Funiture pig;
Funiture globe;
Funiture desk;
Funiture door;

//---------- フラグ ----------
boolean drawerOpened = false;
boolean safeOpened = false;

boolean openingDrawer = false;
boolean openingSafe = false;

boolean pigBroken = false;

boolean globeEnabled = false;

boolean bookMessage = false;

boolean paper1Get = false;
boolean paper2Get = false;
boolean paper3Get = false;
boolean paper4Get = false;

boolean hammerGet = false;

boolean key1Get = false;
boolean key2Get = false;

boolean pencilGet = false;


//=================================
// setup
//=================================
void setup(){

  size(800,600);

  // 画像読込
  room1 = loadImage("room_1.png");
  room2 = loadImage("room_2.png");

  book1 = loadImage("book_1.png");
  book2 = loadImage("book_2.png");

  painting1 = loadImage("painting_1.png");
  painting2 = loadImage("painting_2.png");

  // システム生成
  inventory = new Inventory();
  numberLock = new NumberLock();
  msg = new MessageBox();
  paperPuzzle = new PaperPuzzle();

  //=========================
  // 家具配置
  //=========================

  // 本
  book = new Funiture(
    "book",
    315,
    385,
    170,
    85,
    false
  );

  // 真ん中のタンス
  drawer = new Funiture(
    "drawer",
    450,
    205,
    145,
    190,
    true
  );

  // 金庫
  safe = new Funiture(
    "safe",
    450,
    105,
    135,
    95,
    true
  );

  // ソファ
  sofa = new Funiture(
    "sofa",
    25,
    185,
    250,
    185,
    false
  );

  // 豚
  pig = new Funiture(
    "pig",
    20,
    125,
    75,
    75,
    false
  );

  // 地球儀
  globe = new Funiture(
    "globe",
    35,
    40,
    95,
    105,
    false
  );

  // 机
  desk = new Funiture(
    "desk",
    620,
    290,
    160,
    170,
    true
  );

  // ドア
  door = new Funiture(
    "door",
    275,
    90,
    150,
    300,
    true
  );

}
//=================================
// draw
//=================================
void draw(){

  background(0);

  //------------------------
  // 部屋
  //------------------------
  if(GameState==ROOM){

    image(room1,0,0,width,height);

   
    inventory.display();

    // ナンバーロック表示
    numberLock.display();

    fill(255);
    textSize(16);
    textAlign(LEFT);
    text("アイテムをクリックして選択",15,20);

  }

  //------------------------
  // 本
  //------------------------
  else if(GameState==BOOK){

    background(30);

    image(book1,100,40,600,500);

    // 鉛筆イベント後
    if(bookMessage){

      fill(255,255,180);
      stroke(0);
      rect(170,420,460,80);

      fill(0);
      textAlign(CENTER,CENTER);
      textSize(24);
      text("地球儀の裏を見ろ",400,460);

    }

    fill(255);
    textAlign(CENTER);
    textSize(18);
    text("クリックで閉じる",400,580);

  }
  
  else if(GameState==PAINTING){

    background(30);

    if(paintingSelect==1){

        image(painting1,100,40,600,500);

    }

    if(paintingSelect==2){

        image(painting2,100,40,600,500);

    }

    fill(255);
    textAlign(CENTER);
    textSize(20);
    text("クリックで閉じる",400,580);

}

  //------------------------
  // クリア画面
  //------------------------
  else if(GameState==CLEAR){

    background(40,170,90);
    fill(255);

    textAlign(CENTER,CENTER);

    textSize(60);
    text("GAME CLEAR!",400,230);

    textSize(30);
    text("脱出成功！",400,310);

  }
  msg.display();
  paperPuzzle.display();
 
}

//=================================
// mousePressed
//=================================
void mousePressed(){
  if(paperPuzzle.visible){
    
    paperPuzzle.mousePressed();
    return;
  }
  
  inventory.checkClick(mouseX,mouseY);

  //------------------------
  // NumberLock表示中
  //------------------------
  if(numberLock.visible){

  numberLock.mousePressed();


  if(numberLock.unlocked){

    numberLock.unlocked = false;

    // タンス
    if(openingDrawer){

        drawerOpened = true;
        drawer.locked = false;

        inventory.addItem(
            new Item("magonote","magonote.png")
        );

        msg.show("孫の手を手に入れた");

        openingDrawer = false;
    }

    // 金庫
    else if(openingSafe){

        safeOpened = true;

        inventory.addItem(
            new Item("key_2","key_2.png")
        );

        key2Get = true;

        msg.show("鍵②を手に入れた");

        openingSafe = false;
    }

    return;
   }

  }

  //------------------------
  // 本画面
  //------------------------
  if(GameState == BOOK){

    // 鉛筆入手後に本を見る
    if(pencilGet && !bookMessage){

      bookMessage = true;
      globeEnabled = true;

      msg.show("地球儀の裏を見ろ");
    }

    GameState = ROOM;
    return;
  }
  
  if(GameState==PAINTING){

    GameState=ROOM;

    return;

}

  //------------------------
  // 部屋以外なら終了
  //------------------------
  if(GameState != ROOM) return;
  
  //------------------------
// 左の絵
//------------------------
if(mouseX>=120 &&
   mouseX<=260 &&
   mouseY>=80 &&
   mouseY<=220){

    paintingSelect=1;

    GameState=PAINTING;

    return;

}

//------------------------
// 右の絵
//------------------------
if(mouseX>=500 &&
   mouseX<=640 &&
   mouseY>=80 &&
   mouseY<=220){

    paintingSelect=2;

    GameState=PAINTING;

    return;

}

  //------------------------
  // 本
  //------------------------
  if(book.isClicked(10)){


 if(pencilGet){

   bookMessage=true;

   globeEnabled=true;

 }


 GameState=BOOK;


 return;

}

  //------------------------
  // タンス
  //------------------------
  if(drawer.isClicked(20)){

    if(drawer.locked){
      
      openingDrawer = true;
      openingSafe = false;

      // 本当の答えに変更してOK
      int ans[] = {7,8,3};

      numberLock.open(3,ans);

    }else{

      msg.show("引き出しは開いている");

    }

    return;
  }

  //------------------------
  // ソファ（紙①）
  //------------------------
  if(sofa.isClicked(20)){

    if(!paper1Get &&
       inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("magonote")){

      inventory.addItem(
        new Item("paper_1","paper_1.png")
      );

      paper1Get = true;

      inventory.selectedItem = null;

      msg.show("紙①を入手");
    }

    return;
  }

  //------------------------
  // タンス下（紙②）
  //------------------------
  if(mouseX>455 &&
     mouseX<605 &&
     mouseY>365 &&
     mouseY<440){

    if(!paper2Get &&
       inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("magonote")){

      inventory.addItem(
        new Item("paper_2","paper_2.png")
      );

      paper2Get = true;

      inventory.selectedItem = null;

      msg.show("紙②を入手");
    }

    return;
  }
    //------------------------
  // タンス最下段（ハンマー）
  //------------------------
  if(mouseX>450 &&
     mouseX<605 &&
     mouseY>435 &&
     mouseY<535){

    if(!hammerGet){

      inventory.addItem(
        new Item("hammer","hammer.png")
      );

      hammerGet = true;

      msg.show("ハンマーを手に入れた");
    }

    return;
  }

  //------------------------
  // 豚
  //------------------------
  if(pig.isClicked(8)){

    if(inventory.selectedItem!=null &&
       inventory.selectedItem.id.equals("hammer")){

      if(!pigBroken){

        pigBroken=true;

        inventory.addItem(
          new Item("paper_3","paper_3.png")
        );

        inventory.addItem(
          new Item("key_1","key_1.png")
        );

        key1Get=true;

        msg.show("豚を壊した！紙③と鍵①を入手");
      }

    }else{

      msg.show("カランカラン♪");

    }

    return;
  }

  //------------------------
  // 机
  //------------------------
  if(desk.isClicked()){

   if(key1Get && !pencilGet){

    pencilGet=true;

    inventory.addItem(
        new Item(
            "pencil",
            "pencil.png"
        )
    );

    msg.show("鉛筆を手に入れた");

    }

    return;
  }

  //------------------------
  // 地球儀
  //------------------------
  if(globe.isClicked(10)){

    if(globeEnabled && !paper4Get){

      inventory.addItem(
        new Item("paper_4","paper_4.png")
      );

      paper4Get=true;

      msg.show("紙④を入手");

    }

    return;
  }

 //------------------------
// 金庫
//------------------------
if(safe.isClicked(5)){

  if(paper1Get &&
     paper2Get &&
     paper3Get &&
     paper4Get){

      openingDrawer = false;
      openingSafe = true;

      int ans[]={6,1,8,3};

      numberLock.open(4,ans);

  }else{

      msg.show("紙が足りない");

  }

  return;

}

//------------------------
// ドア
//------------------------
if(door.isClicked(30)){


  if(key2Get){

    GameState=CLEAR;


  }else{

    msg.show(
      "鍵がかかっている"
    );

  }


  return;

}

}
 
//==============================
// App.pde 終了
//==============================
