class Item{

  String id;

  PImage img;

  Item(String id,String imgName){

    this.id=id;

    img=loadImage(imgName);

  }

  //--------------------------
  // アイコン表示
  //--------------------------
  void drawIcon(float x,
                float y,
                float size,
                boolean selected){

    // 枠
    if(selected){

      stroke(255,255,0);
      strokeWeight(3);

    }else{

      stroke(255);
      strokeWeight(1);

    }

    fill(80);

    rect(x,y,size,size);

    // 画像がある場合
    if(img!=null){

      image(
        img,
        x+5,
        y+5,
        size-10,
        size-10
      );

    }else{

      fill(255);

      textAlign(CENTER,CENTER);

      textSize(10);

      text(id,
           x+size/2,
           y+size/2);

    }

  }

}
