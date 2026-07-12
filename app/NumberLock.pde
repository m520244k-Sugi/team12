class NumberLock{
  boolean visible;
  boolean unlocked;
  int digit;
  int[] answer;
  int[] number;
  
  NumberLock() {
    visible = false;
    unlocked = false;
  }

  void open(int digit,int ans[]){
      visible=true;
      unlocked=false;
      this.digit=digit;
      answer=ans;
      number=new int[digit];
      for(int i=0;i<digit;i++){
          number[i]=0;
      }
  }
  
  void display(){
      if(!visible)return;
      
      fill(0, 150);
      rect(0, 0, width, height);
      
      fill(240);
      rect(150, 100, 500, 250);
      
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text("NUMBER LOCK",400,140);
      
      for(int i=0;i<digit;i++){
          fill(255);
          rect(200+i*70,200,50,50);
  
          fill(0);
          textAlign(CENTER,CENTER);
          textSize(30);
          text(number[i],225+i*70,225);
      }
      
      fill(255);
      stroke(0);
      rect(580,120,40,40);
      fill(0);
      textAlign(CENTER,CENTER);
      text("×",750,40);
      
      textAlign(LEFT, BASELINE);
      
      noStroke();
  }
  
  void mousePressed(){
    if(!visible)return;
    
    if(mouseX>=580 && mouseX<=620 && mouseY>=120 && mouseY<=160){
        visible = false;
        return;
    }
    
    for(int i=0;i<digit;i++){
        int x=200+i*70;
        if(mouseX>x && mouseX<x+50 && mouseY>200 && mouseY<250){
            number[i]++;
            if(number[i]>9){
                number[i]=0;
            }
            check();
        }
    }
}
  
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
      }
  }
}
