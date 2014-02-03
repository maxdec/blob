part of blob;

class SpriteHandler {
  String name;
  Map spriteMap;
  ImageElement image;

  SpriteHandler(this.name);

  Future ready() {
    return HttpRequest.getString('spritemaps/$name.json')
      .then((String jsonString) {
        spriteMap = JSON.decode(jsonString);
        image = new ImageElement()
          ..src = 'sprites/${spriteMap['sprite']}.png';
        return image.onLoad.first;
      });
  }

  Map properties() => spriteMap['properties'];

  /**
   * Example:
   * draw('direction', 1, 3) -> draws the 4th animation step of the RIGHT direction
   */
  void draw(CanvasRenderingContext2D ctx, num xDest, num yDest, String what, [num pos1, num pos2]) {
    var properties = spriteMap['properties'];
    var whatToDraw = spriteMap['map'][what];
    if (pos1 != null) whatToDraw = whatToDraw[pos1];
    if (pos2 != null) whatToDraw = whatToDraw[pos2];

    var destRect = new Rectangle(xDest, yDest, properties['dx'], properties['dy']);
    var sourceRect = new Rectangle(whatToDraw['x'], whatToDraw['y'], properties['dx'], properties['dy']);

    ctx.drawImageToRect(image, destRect, sourceRect: sourceRect);
  }
}
