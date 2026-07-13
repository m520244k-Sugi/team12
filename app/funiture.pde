class Funiture extends GameObject {

  String name;
  boolean locked;

  Funiture(String name,
            float x,float y,
            float w,float h,
            boolean locked){

    super(x,y,w,h);

    this.name=name;
    this.locked=locked;
  }

  void action(){

    if(name.equals("book")){

        GameState = PUZZLE;

    }

    else if(name.equals("drawer")){

        if(locked){

            // NumberLockを表示

        }else{

            // 引き出しを開く

        }

    }

    else if(name.equals("safe")){

        if(locked){

            // NumberLockを表示

        }else{

            // 金庫を開く

        }

    }

    else if(name.equals("door")){

        if(locked){

            println("鍵がかかっている");

        }else{

            GameState = CLEAR;

        }

    }

    else if(name.equals("painting")){

        // 絵画を拡大表示

    }

  }

}
