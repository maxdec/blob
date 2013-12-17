part of blob;

class GameMap {
  String name;
  Map mapData;
  Tileset ts;
  List area;

  GameMap(this.name);

  Future ready() {
    return HttpRequest.getString('maps/$name.json')
      .then((String jsonString) {
        mapData = JSON.decode(jsonString);
        ts = new Tileset(mapData['tileset']);
        area = mapData['area'];
        return ts.ready();
      });
  }

  void drawMap() {
    for(var i = 0, l = getHeight(); i < l ; i++) {
      var line = area[i];
      var y = i * 32;
      for(var j = 0, k = line.length ; j < k ; j++) {
        ts.drawTile(line[j], j * 32, y);
      }
    }
  }

  num getHeight() => area.length;
  num getWidth() => area[0].length;
}