//=================================
// App.pde 前半①
//=================================

//---------- GameState ----------
final int ROOM = 0;
final int BOOK = 1;
final int PAINTING = 2;
final int PIG = 3;
final int CLEAR = 4;

int GameState = ROOM;

//---------- 画像 ----------
PImage room1;
PImage room2;

PImage book1;
PImage book2;

PImage painting1;
PImage painting2;

PImage pig1;
PImage pig2;

int paintingSelect = 0;

//---------- システム ----------
Inventory inventory;
NumberLock numberLock;
MessageBox msg;

//---------- 家具 ----------
Funiture book;
Funiture drawer;
Funiture safe;
Funiture sofa;
Funiture pig;
Funiture globe;
Funiture shelf;
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
  //フォント指定
  PFont font = createFont("Meiryo", 50);
  textFont(font);

  size(1536,1024);

  // 画像読込
  room1 = loadImage("room_1.png");
  room2 = loadImage("room_2.png");

  book1 = loadImage("book_1.png");
  book2 = loadImage("book_2.png");

  painting1 = loadImage("painting_1.png");
  painting2 = loadImage("painting_2.png");
  
  pig1 = loadImage("pig_1.png");   
  pig2 = loadImage("pig_2.png");

  // システム生成
  inventory = new Inventory();
  numberLock = new NumberLock();
  msg = new MessageBox();

  //=========================
  // 家具配置
  //=========================

  // 本
  book = new Funiture(
    "book",
    675,
    675,
    200,
    100,
    false
  );

  // 真ん中のタンス(上段)
  drawer = new Funiture(
    "drawer",
    900,
    550,
    200,
    50,
    true
  );

  // 金庫
  safe = new Funiture(
    "safe",
    900,
    425,
    200,
    125,
    true
  );

  // ソファ
  sofa = new Funiture(
    "sofa",
    225,
    650,
    325,
    250,
    false
  );

  // 豚
  pig = new Funiture(
    "pig",
    25,
    500,
    125,
    125,
    false
  );

  // 地球儀
  globe = new Funiture(
    "globe",
    50,
    300,
    150,
    150,
    false
  );

  // 右の棚
  shelf = new Funiture(
    "shelf",
    1300,
    250,
    236,
    375,
    true
  );

  // ドア
  door = new Funiture(
    "door",
    575,
    225,
    250,
    450,
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
    textSize(30);
    textAlign(LEFT);
    text("アイテムをクリックして選択",15,40);

  }

  //------------------------
  // 本
  //------------------------
  else if(GameState==BOOK){

    background(30);
    
    if(bookMessage){ // 鉛筆イベント後
    image(book2,260,180,1024,559);
    }else{
     image(book1,260,180,1024,559);
    }

    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("クリックで閉じる",768,800);

  }
  
  //------------------------
  // 豚
  //------------------------
  
  else if(GameState==PIG){

    background(30);
    
    if(pigBroken){ // 破壊イベント後
    image(pig2,410,230,675,531);
    }else{
     image(pig1,410,230,675,531);
    }

    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("クリックで閉じる",768,800);

  }

  //------------------------
  // 絵
  //------------------------
  
  else if(GameState==PAINTING){

    background(30);

    if(paintingSelect==1){

        image(painting1,520,80,501,640);

    }

    if(paintingSelect==2){

        image(painting2,520,80,501,640);

    }

    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("クリックで閉じる",768,800);

}

  //------------------------
  // クリア画面
  //------------------------
  else if(GameState==CLEAR){

    image(room2,0,0,width,height);

    textAlign(CENTER,CENTER);

    textSize(60);
    text("GAME CLEAR!",768,300);

    textSize(100);
    text("脱出成功！",768,512);

  }
  msg.display();
 
}

//=================================
// mousePressed
//=================================
void mousePressed(){
  
  inventory.checkClick(mouseX,mouseY);

  //------------------------
  // NumberLock表示中
  //------------------------
  if(numberLock.visible){

    numberLock.mousePressed();
  
    if(numberLock.unlocked){
  
      numberLock.unlocked = false;
  
      // 真ん中タンス上段
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
          safe.locked = false;
  
          inventory.addItem(
              new Item("key_2","key_2.png")
          );
  
          key2Get = true;
  
          msg.show("鍵②を手に入れた");
  
          openingSafe = false;
      }
    }
    return;
  }

  //------------------------
  // 本画面
  //------------------------
  if(GameState == BOOK){

    GameState = ROOM;
    return;
  }
  
  //------------------------
  // 豚画面
  //------------------------
  if(GameState == PIG){

    GameState = ROOM;
    return;
  }

  //------------------------
  // 絵画面
  //------------------------
  
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
  if(mouseX>=250 &&
     mouseX<=350 &&
     mouseY>=225 &&
     mouseY<=425){
  
      paintingSelect=1;
  
      GameState=PAINTING;
  
      return;
  }

  //------------------------
  // 右の絵
  //------------------------
  if(mouseX>=875 &&
     mouseX<=1025 &&
     mouseY>=250 &&
     mouseY<=400){
  
      paintingSelect=2;
  
      GameState=PAINTING;
  
      return;
  
  }

  //------------------------
  // 本
  //------------------------
  if(book.isClicked()){
    
    // 鉛筆を装備して本を見る
    if(inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("pencil") &&
       !bookMessage){

      bookMessage = true;
      globeEnabled = true;
      
      msg.show("文字が浮かび出てきた！");

    }else if(pencilGet &&
             !bookMessage){
      msg.show("うっすらと文字が書かれた跡が見える");
    }
    
     GameState=BOOK;
    
     return;
    
    }

  //------------------------
  // 真ん中タンス上段
  //------------------------
  if(drawer.isClicked()){

    if(drawer.locked){
      
      openingDrawer = true;
      openingSafe = false;

      // 羊7、豚8、牛3
      int ans[] = {7,8,3};

      numberLock.open(3,ans);

    }else{

      msg.show("引き出し(上段)は開いている");

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

      msg.show("紙「6」を入手");
    }else if(!paper1Get){
      msg.show("奥に何かあるようだが手が届かない・・・");
    }

    return;
  }

  //------------------------
  // 右の棚の下（紙②）
  //------------------------
  if(mouseX>1225 &&
     mouseX<1350 &&
     mouseY>850 &&
     mouseY<1024){

    if(!paper2Get &&
       inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("magonote")){

      inventory.addItem(
        new Item("paper_2","paper_2.png")
      );

      paper2Get = true;

      inventory.selectedItem = null;

      msg.show("紙「1」を入手");
    }else if(!paper2Get){
      msg.show("奥に何かあるようだが手が届かない・・・");
    }

    return;
  }
    //------------------------
  // 真ん中タンス下段（ハンマー）
  //------------------------
  if(mouseX>900 &&
     mouseX<1100 &&
     mouseY>600 &&
     mouseY<700){

    if(!hammerGet){

      inventory.addItem(
        new Item("hammer","hammer.png")
      );

      hammerGet = true;

      msg.show("ハンマーを手に入れた");
    }else{

      msg.show("引き出し(下段)は開いている");

    }

    return;
  }

  //------------------------
  // 豚
  //------------------------
  if(pig.isClicked()){

    // ハンマーを装備して豚をクリック
    if(inventory.selectedItem != null &&
       inventory.selectedItem.id.equals("hammer") &&
       !pigBroken){

      pigBroken = true;
      
      inventory.addItem(
       new Item("paper_3","paper_3.png")
      );

      inventory.addItem(
       new Item("key_1","key_1.png")
      );

      key1Get=true;
      paper3Get=true;

      msg.show("豚を壊した！紙「8」と鍵①を入手");
    }
    
    GameState=PIG;

    return;
  }

  //------------------------
  // 右の棚(鍵)
  //------------------------
  if(shelf.isClicked()){

   if(inventory.selectedItem != null &&
      inventory.selectedItem.id.equals("key_1") &&
      !pencilGet){

    pencilGet=true;

    inventory.addItem(
        new Item(
            "pencil",
            "pencil.png"
        )
    );

    msg.show("鉛筆を手に入れた");

    }else if(!pencilGet){
      msg.show("鍵がかかっている");
    }else {
      msg.show("戸棚の扉は開いている");
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

      msg.show("紙「3」を入手");

    }

    return;
  }

  //------------------------
  // 金庫
  //------------------------
  if(safe.isClicked()){
  
    if(safe.locked){
      
      if(paper1Get &&
       paper2Get &&
       paper3Get &&
       paper4Get){
         msg.show("紙と関係しているようだが・・・");
       }
        
        openingDrawer = false;
        openingSafe = true;
  
        // 紙1,紙2,紙3,紙4
        int ans[] = {6,1,8,3};
  
        numberLock.open(4,ans);
  
      }else{
  
        msg.show("金庫は開いている");
  
      }
  
  }
  
  //------------------------
  // ドア
  //------------------------
  if(door.isClicked()){
  
  
    if(key2Get &&
       inventory.selectedItem!=null &&
       inventory.selectedItem.id.equals("key_2")){
  
      GameState=CLEAR;
  
  
    }else if(key1Get &&
       inventory.selectedItem!=null &&
       inventory.selectedItem.id.equals("key_1")){
    
      msg.show(
        "鍵が合わない！"
      );   
         
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
