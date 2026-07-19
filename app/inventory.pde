class Inventory{

  ArrayList<Item> items;

  Item selectedItem;

  float slotSize=100;
  float xOffset=20;
  float yPos;

  Inventory(){

    items=new ArrayList<Item>();

    selectedItem=null;

    yPos=height-150;

  }

  //--------------------
  // アイテム追加
  //--------------------
  void addItem(Item item){

    if(item!=null){

      items.add(item);

    }

  }

  //--------------------
  // アイテム削除
  //--------------------
  void removeItem(Item item){

    if(selectedItem==item){

      selectedItem=null;

    }

    items.remove(item);

  }

  //--------------------
  // 表示
  //--------------------
  void display(){

    for(int i=0;i<items.size();i++){

      float x=xOffset+i*(slotSize+10);

      items.get(i).drawIcon(
        x,
        yPos,
        slotSize,
        selectedItem==items.get(i)
      );

    }

  }

  //--------------------
  // クリック
  //--------------------
  void checkClick(int mx,int my){

    for(int i=0;i<items.size();i++){

      float x=xOffset+i*(slotSize+10);

      if(mx>x &&
         mx<x+slotSize &&
         my>yPos &&
         my<yPos+slotSize){

        if(selectedItem==items.get(i)){

          selectedItem=null;

        }else{

          selectedItem=items.get(i);

        }

        return;

      }

    }

  }

}
