part of blob;

class GameMap {
  String name;
  Map mapData;
  SpriteHandler spriteh;
  List<List> area;

  GameMap(String name) {
    this.name = name;
    spriteh = new SpriteHandler(name);
  }

  Future ready() {
    return HttpRequest.getString('maps/$name.json')
      .then((String jsonString) {
        mapData = JSON.decode(jsonString);
        spriteh = new SpriteHandler(mapData['spritemap']);
        area = mapData['area'];
        return spriteh.ready();
      });
  }

  void drawMap() {
    for(var i = 0; i < area.length ; i++) {
      var line = area[i];
      var y = i * 32;
      for(var j = 0, k = line.length ; j < k ; j++) {
        spriteh.draw(ctx, j * 32, y, 'textures', line[j]);
      }
    }
  }

  void draw(Rectangle rect) {
    var props = spriteh.properties();
    var minRow = (rect.top / props['dy']).floor();
    var maxRow = (rect.bottom / props['dy']).ceil();
    var minCol = (rect.left / props['dx']).floor();
    var maxCol = (rect.right / props['dx']).ceil();
//    print(minRow);print(maxRow);print(minCol);print(maxCol);
    for (var i = minRow; i < maxRow; i++) {
      for(var j = minCol; j < maxCol ; j++) {
        spriteh.draw(ctx2, j * props['dx'], i * props['dy'], 'textures', area[i][j]);
      }
    }
  }

  num getHeight() => area.length * spriteh.spriteMap['properties']['dy'];
  num getWidth() => area[0].length * spriteh.spriteMap['properties']['dx'];
}