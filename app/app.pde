//=================================
// App.pde 前半①
//=================================

//---------- GameState ----------
final int ROOM = 0;
final int BOOK = 1;
final int CLEAR = 2;

int GameState = ROOM;

//---------- 画像 ----------
PImage room1;
PImage room2;

PImage book1;
PImage book2;

PImage painting1;
PImage painting2;

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
    330,
    380,
    140,
    90,
    false
  );

  // 真ん中のタンス
  drawer = new Funiture(
    "drawer",
    455,
    200,
    140,
    180,
    true
  );

  // 金庫
  safe = new Funiture(
    "safe",
    455,
    115,
    120,
    80,
    true
  );

  // ソファ
  sofa = new Funiture(
    "sofa",
    35,
    190,
    240,
    180,
    false
  );

  // 豚
  pig = new Funiture(
    "pig",
    15,
    120,
    70,
    70,
    false
  );

  // 地球儀
  globe = new Funiture(
    "globe",
    45,
    55,
    90,
    90,
    false
  );

  // 机
  desk = new Funiture(
    "desk",
    620,
    300,
    150,
    150,
    true
  );

  // ドア
  door = new Funiture(
    "door",
    270,
    90,
    150,
    280,
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

    // 持ち物表示
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


    // タンス解除
    if(!drawerOpened){

      drawerOpened=true;

      drawer.locked=false;


      inventory.addItem(
        new Item(
          "magonote",
          "magonote.png"
        )
      );


      msg.show(
        "孫の手を手に入れた"
      );

    }


    // 金庫解除
    else if(!safeOpened){


      safeOpened=true;


      inventory.addItem(
        new Item(
          "key_2",
          "key_2.png"
        )
      );


      key2Get=true;


      msg.show(
        "鍵②を手に入れた"
      );

    }

  }


  return;

}

  //------------------------
  // 本画面
  //------------------------
  if(GameState == BOOK){

    // 鉛筆入手後に本を見る
    if(pencilGet && !bookMessage){

      bookMessage = true;
      globeEnabled = true;

      println("地球儀の裏を見ろ");
    }

    GameState = ROOM;
    return;
  }

  //------------------------
  // 部屋以外なら終了
  //------------------------
  if(GameState != ROOM) return;

  //------------------------
  // 本
  //------------------------
  if(book.isClicked()){


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
  if(drawer.isClicked()){

    if(drawer.locked){

      // 本当の答えに変更してOK
      int ans[] = {2,5,8};

      numberLock.open(3,ans);

    }else{

      println("引き出しは開いている");

    }

    return;
  }

  //------------------------
  // ソファ（紙①）
  //------------------------
  if(sofa.isClicked()){

    if(!paper1Get &&
       inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("magonote")){

      inventory.addItem(
        new Item("paper_1","paper_1.png")
      );

      paper1Get = true;

      inventory.selectedItem = null;

      println("紙①を入手");
    }

    return;
  }

  //------------------------
  // タンス下（紙②）
  //------------------------
  if(mouseX>450 &&
     mouseX<600 &&
     mouseY>360 &&
     mouseY<430){

    if(!paper2Get &&
       inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("magonote")){

      inventory.addItem(
        new Item("paper_2","paper_2.png")
      );

      paper2Get = true;

      inventory.selectedItem = null;

      println("紙②を入手");
    }

    return;
  }
    //------------------------
  // タンス最下段（ハンマー）
  //------------------------
  if(mouseX>450 &&
     mouseX<600 &&
     mouseY>430 &&
     mouseY<520){

    if(!hammerGet){

      inventory.addItem(
        new Item("hammer","hammer.png")
      );

      hammerGet = true;

      println("ハンマーを手に入れた");
    }

    return;
  }

  //------------------------
  // 豚
  //------------------------
  if(pig.isClicked()){

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

        println("豚を壊した！");
      }

    }else{

      println("カランカラン♪");

    }

    return;
  }

  //------------------------
  // 机
  //------------------------
  if(desk.isClicked()){

    if(key1Get && !pencilGet){

      pencilGet=true;

      println("鉛筆を手に入れた");

    }

    return;
  }

  //------------------------
  // 地球儀
  //------------------------
  if(globe.isClicked()){

    if(globeEnabled && !paper4Get){

      inventory.addItem(
        new Item("paper_4","paper_4.png")
      );

      paper4Get=true;

      println("紙④を入手");

    }

    return;
  }

  //------------------------
// 金庫
//------------------------
if(safe.isClicked()){


  if(paper1Get &&
     paper2Get &&
     paper3Get &&
     paper4Get){


    paperPuzzle.open();


  }else{


    msg.show(
      "紙が足りない"
    );


  }


  return;

}
//------------------------
// ドア
//------------------------
if(door.isClicked()){


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
