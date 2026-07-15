class Funiture extends GameObject{

  String name;

  boolean locked;

  Funiture(String name,
           float x,
           float y,
           float w,
           float h,
           boolean locked){

    super(x,y,w,h);

    this.name=name;

    this.locked=locked;

  }

}
