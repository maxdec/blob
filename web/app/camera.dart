part of blob;

class Camera {
  static const width = 100;
  static const height = 70;
  Rectangle _rect;

  Camera (num x,num y) {
    set(x, y);
  }

  void set(num x, num y) {
    _rect = new Rectangle(x, y, width, height);
  }

  void track(Character player) {
    var x = player.x + player.width/2 - width/2;
    var y = player.y + player.height/2 - height/2;
    set(x, y);
  }

  void draw(World w) {
    w.map.drawMap();
    w.player.draw();
    for(var i = 0; i < w.characters.length ; i++) {
      w.characters[i].draw();
    }
    ctx.beginPath();
    ctx.strokeStyle = 'red';
    ctx.rect(_rect.left, _rect.top, _rect.width, _rect.height);
    ctx.stroke();
    ctx.closePath();

    render(w);
  }

  void render(World w) {
    w.map.draw(_rect);
  }
}