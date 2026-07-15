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
    rect(150,100,500,250);

    fill(0);
    textAlign(CENTER);

    textSize(34);
    text("NUMBER LOCK",400,145);

    // 数字
    for(int i=0;i<digit;i++){

      int x=200+i*70;

      fill(255);
      rect(x,200,50,50);

      fill(0);

      textSize(30);
      text(number[i],x+25,235);

    }

    // ×ボタン
    fill(255);

    rect(580,120,40,40);

    fill(0);

    textSize(28);
    text("×",600,148);

    noStroke();

  }

  //==========================
  // クリック
  //==========================
  void mousePressed(){

    if(!visible)return;

    // 閉じる
    if(mouseX>=580 &&
       mouseX<=620 &&
       mouseY>=120 &&
       mouseY<=160){

      visible=false;
      return;

    }

    // 数字変更
    for(int i=0;i<digit;i++){

      int x=200+i*70;

      if(mouseX>x &&
         mouseX<x+50 &&
         mouseY>200 &&
         mouseY<250){

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
