class Furniture extends GameObject {
  String name;
  boolean locked;
  Furniture(String name,
            float x, float y,
            float w, float h,
            boolean locked) {
    super(x, y, w, h);
    this.name = name;
    this.locked = locked;
  }
  // 家具クリック時の処理
  void action() {
    switch(name) {
      // 本
      case "book":
        GameState = PUZZLE;
        break;
      // 引き出し
      case "drawer":
        if(locked) {
          println("引き出しには鍵がかかっています");
          // NumberLock画面へ
          GameState = NUMBER_LOCK;
        }
        else {
          println("引き出しを開きました");

          // アイテム取得処理

        }
        break;
      // 金庫
      case "safe":
        if(locked) {
          println("金庫には鍵がかかっています");
          // NumberLock画面へ
          GameState = NUMBER_LOCK;
        }
        else {
          println("金庫を開きました");
          // アイテム取得処理
        }
        break;
      // 扉
      case "door":
        if(locked) {
          println("扉に鍵がかかっています");
        }
        else {
          GameState = CLEAR;
        }
        break;
      // 絵画
      case "painting":
        println("絵画を調べています");
        // 拡大表示処理
        break;
      default:
        println("未定義の家具です");
        break;
    }
  }
  // ロック解除処理
  void unlock() {
    locked = false;
    println(name + "の鍵を解除しました");
  }
}
