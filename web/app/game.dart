part of blob;

CanvasRenderingContext2D ctx;

final DIRECTION = {
  'DOWN': 0,
  'LEFT': 1,
  'RIGHT': 2,
  'UP': 3
};

class Game {
  CanvasElement canvas;
  Tileset ts;
  GameMap map;
  List<Character> characters;
  bool ready;

  Game() {
    canvas = querySelector("#game_canvas");
    ctx = canvas.getContext('2d');

    map = new GameMap('first');
    characters = [
      new Character('perso1', 7, 14, DIRECTION['UP']),
      new Character('perso1', 7, 0, DIRECTION['DOWN']),
      new Character('perso1', 0, 7, DIRECTION['RIGHT']),
      new Character('perso1', 14, 7, DIRECTION['LEFT'])
    ];
  }

  void runWhenReady() {
    var futures = [map.ready()]
      ..addAll(characters.map((Character c) {
        return c.ready();
      }));

    Future.wait(futures).then((_) {
      canvas.width  = map.getWidth() * 32;
      canvas.height = map.getHeight() * 32;
      window.requestAnimationFrame(render);
    });
  }

  void render(double time) {
    map.drawMap();
    for(var i = 0; i < characters.length ; i++) {
      characters[i].drawCharacter();
    }
    //window.requestAnimationFrame(render);
  }

  void addCharacter(Character char) {
    characters.add(char);
  }
}