class Item {
  String id;      // hammer, key_1, pig_1 など
  PImage img;     // 画像データ

  Item(String id, String imgPath) {
    this.id = id;
    this.img = loadImage(imgPath); // dataフォルダ内の画像名
  }

  // 持ち物スロットへの描画
  void drawIcon(float x, float y, float size, boolean isSelected) {
    if (isSelected) {
      stroke(255, 255, 0); // 選択中は黄色枠
      strokeWeight(3);
    } else {
      stroke(255);
      strokeWeight(1);
    }
    fill(0, 100); // スロット背景
    rect(x, y, size, size);
    
    // 画像をスロット内にリサイズして表示
    image(img, x + 5, y + 5, size - 10, size - 10);
  }
}