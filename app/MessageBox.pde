class MessageBox{

  String message="";

  int timer=0;

  //--------------------
  // メッセージ表示
  //--------------------
  void show(String msg){

    message=msg;

    timer=180;   // 約3秒

  }

  //--------------------
  // 描画
  //--------------------
  void display(){

    if(timer<=0)return;

    fill(0,180);
    noStroke();
    rect(100,510,600,45,10);

    fill(255);
    textAlign(CENTER,CENTER);
    textSize(20);

    text(message,400,532);

    timer--;

  }

}
