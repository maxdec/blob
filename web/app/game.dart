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
  Character player;
  List<Character> characters;
  Keyboard keyboard;

  Game() {
    keyboard = new Keyboard();
    canvas = querySelector("#game_canvas");
    ctx = canvas.getContext('2d');

    map = new GameMap('first');
    characters = [];
    player = new Character('perso1', 7, 14, DIRECTION['DOWN']);
  }

  void runWhenReady() {
    var futures = [map.ready(), player.ready()]
      ..addAll(characters.map((Character c) {
        return c.ready();
      }));

    Future.wait(futures).then((_) {
      canvas.width  = map.getWidth() * 32;
      canvas.height = map.getHeight() * 32;
      window.requestAnimationFrame(renderLoop);
    });
  }

  void renderLoop(double time) {
    moves();
    map.drawMap();
    player.drawCharacter();
    for(var i = 0; i < characters.length ; i++) {
      characters[i].drawCharacter();
    }
    window.requestAnimationFrame(renderLoop);
  }

  void addCharacter(Character char) {
    characters.add(char);
  }

  void moves() {
    if (keyboard.isPressed(KeyCode.A)) player.move(DIRECTION['LEFT'], map);
    if (keyboard.isPressed(KeyCode.D)) player.move(DIRECTION['RIGHT'], map);
    if (keyboard.isPressed(KeyCode.W)) player.move(DIRECTION['UP'], map);
    if (keyboard.isPressed(KeyCode.S)) player.move(DIRECTION['DOWN'], map);

    if (keyboard.areNotPressed([KeyCode.A, KeyCode.D, KeyCode.W, KeyCode.S])) {
      player.animationState = -1;
    }
  }
}