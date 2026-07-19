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

  return mouseX >= x + 0.05 * w &&
         mouseX <= x + 0.95 * w &&
         mouseY >= y + 0.05 * h&&
         mouseY <= y + 0.95 * h;

 }

}
