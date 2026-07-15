class PaperPuzzle{

  boolean visible=false;

  PImage paper1;
  PImage paper2;
  PImage paper3;
  PImage paper4;


  PaperPuzzle(){

    paper1=loadImage("paper_1.png");
    paper2=loadImage("paper_2.png");
    paper3=loadImage("paper_3.png");
    paper4=loadImage("paper_4.png");

  }


  //--------------------
  // 開く
  //--------------------
  void open(){

    visible=true;

  }


  //--------------------
  // 表示
  //--------------------
  void display(){

    if(!visible)return;


    fill(0,180);
    rect(0,0,width,height);


    fill(255);
    rect(100,80,600,420);


    image(
      paper1,
      150,
      130,
      120,
      160
    );


    image(
      paper2,
      290,
      130,
      120,
      160
    );


    image(
      paper3,
      430,
      130,
      120,
      160
    );


    image(
      paper4,
      290,
      320,
      120,
      160
    );


    fill(0);

    textAlign(CENTER);

    textSize(28);

    text(
      "紙を組み合わせた",
      400,
      520
    );


    textSize(35);

    text(
      "金庫番号：4712",
      400,
      570
    );


  }


  //--------------------
  // 閉じる
  //--------------------
  void mousePressed(){

    if(!visible)return;


    visible=false;

  }

}
