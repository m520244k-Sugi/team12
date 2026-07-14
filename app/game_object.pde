class GameObject {
  float x;
  float y;
  float w;
  float h;
  GameObject(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  boolean isClicked() {
    return mouseX >= x &&
           mouseX <= x + w &&
           mouseY >= y &&
           mouseY <= y + h;
  }
}
