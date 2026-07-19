class NumberLock{

  boolean visible=false;
  boolean unlocked=false;

  int digit;

  int[] answer;
  int[] number;

  NumberLock(){

  }

  //==========================
  // ロックを開く
  //==========================
  void open(int digit,int ans[]){

    visible=true;
    unlocked=false;

    this.digit=digit;

    answer=new int[digit];
    number=new int[digit];

    for(int i=0;i<digit;i++){

      answer[i]=ans[i];
      number[i]=0;

    }

  }

  //==========================
  // 表示
  //==========================
  void display(){

    if(!visible)return;

    fill(0,170);
    rect(0,0,width,height);

    fill(240);
    stroke(0);
    rect(450,250,650,400);  

    fill(0);
    textAlign(CENTER);

    textSize(34);
    text("暗証番号を入力",775,320);

    // 数字
    for(int i=0;i<digit;i++){

      int x = 625+i*100;
      if (digit == 4){
        x = 580+i*100;
      }

      fill(255);
      rect(x,400,100,150);

      fill(0);

      textSize(40);
      text(number[i],x+50,490);

    }

    // ×ボタン
    fill(255);

    rect(1000,270,50,50);

    fill(0);

    textSize(28);
    text("×",1025,305);

    noStroke();

  }

  //==========================
  // クリック
  //==========================
  void mousePressed(){

    if(!visible)return;

    // 閉じる
    if(mouseX>=1000 &&
       mouseX<=1050 &&
       mouseY>=270 &&
       mouseY<=320){

      visible=false;
      return;

    }

    // 数字変更
    for(int i=0;i<digit;i++){

      int x = 625+i*100;
      if (digit == 4){
        x = 580+i*100;
      }

      if(mouseX>x &&
         mouseX<x+100 &&
         mouseY>400 &&
         mouseY<550){

        number[i]++;

        if(number[i]>9){

          number[i]=0;

        }

        check();

      }

    }

  }

  //==========================
  // 正解判定
  //==========================
  void check(){

    boolean ok=true;

    for(int i=0;i<digit;i++){

      if(number[i]!=answer[i]){

        ok=false;

      }

    }

    if(ok){

      unlocked=true;
      visible=false;

      println("ロック解除！");

    }

  }

}
