class GameObject{

  float x;
  float y;
  float w;
  float h;


  GameObject(float x,
             float y,
             float w,
             float h){

    this.x=x;
    this.y=y;

    this.w=w;
    this.h=h;

  }


  //クリックされたか確認
 boolean isClicked(){

  return mouseX >= x + w*0.35 &&
         mouseX <= x + w*0.65 &&
         mouseY >= y + h*0.35 &&
         mouseY <= y + h*0.65;

}
  //----------------------
// 当たり判定を狭くする
//----------------------
boolean isClicked(float margin){

  return mouseX>=x+margin &&
         mouseX<=x+w-margin &&
         mouseY>=y+margin &&
         mouseY<=y+h-margin;

}

}
