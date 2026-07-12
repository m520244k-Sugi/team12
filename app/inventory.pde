class Inventory {
  ArrayList<Item> items = new ArrayList<Item>();
  Item selectedItem = null;
  
  float slotSize = 70;
  float xOffset = 20;
  float yPos;

  Inventory() {
    yPos = height - 90; // 画面下部に配置
  }

  // アイテム追加
  void addItem(Item it) {
    if (it != null) items.add(it);
  }

  // アイテム削除
  void removeItem(Item it) {
    if (selectedItem == it) selectedItem = null;
    items.remove(it);
  }

  void display() {
    for (int i = 0; i < items.size(); i++) {
      float x = xOffset + i * (slotSize + 10);
      items.get(i).drawIcon(x, yPos, slotSize, (selectedItem == items.get(i)));
    }
  }

  // アイテム欄をクリックした時の処理
  void checkClick(int mx, int my) {
    for (int i = 0; i < items.size(); i++) {
      float x = xOffset + i * (slotSize + 10);
      if (mx > x && mx < x + slotSize && my > yPos && my < yPos + slotSize) {
        Item clickedItem = items.get(i);

        // --- 合成ロジック：ハンマーを選択中に豚(pig_1)をクリック ---
        if (selectedItem != null && selectedItem.id.equals("hammer") && clickedItem.id.equals("pig_1")) {
          items.remove(clickedItem);       // pig_1を消す
          addItem(new Item("pig_2", "pig_2.png"));   // 壊れた豚を追加
          addItem(new Item("paper_3", "paper_3.png")); // 中から出た紙を追加
          selectedItem = null; // 選択解除
          println("豚を壊して紙(paper_3)を手に入れた！");
        } else {
          // 通常の選択
          selectedItem = clickedItem;
        }
        return;
      }
    }
  }
}