part of blob;

class Tileset {
  ImageElement image;
  num width;

  Tileset(String name) {
    width = 32;
    image = new ImageElement()
      ..src = 'sprites/$name.png';
  }

  Future ready() {
    return image.onLoad.first.then((_){
      width = image.width / 32; // Width in tiles
    });
  }

  void drawTile(num nb, num xDest, num yDest) {
    var xSourceInTiles = nb % width;
    if(xSourceInTiles == 0) xSourceInTiles = width;
    var ySourceInTiles = (nb / width).ceil();
    var xSource = (xSourceInTiles - 1) * 32;
    var ySource = (ySourceInTiles - 1) * 32;
    ctx.drawImageScaledFromSource(image, xSource, ySource, 32, 32, xDest, yDest, 32, 32);
  }
}
