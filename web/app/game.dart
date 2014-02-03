part of blob;

CanvasRenderingContext2D ctx, ctx2;
CanvasElement canvas, canvas2;

final DIRECTION = {
  'UP': 0,
  'RIGHT': 1,
  'DOWN': 2,
  'LEFT': 3
};

class Game {
  CanvasElement canvas;
  Keyboard keyboard;
  Camera camera;
  World world;

  Game() {
    keyboard = new Keyboard();
    canvas = querySelector("#global_canvas");
    canvas2 = querySelector("#game_canvas");
    ctx = canvas.getContext('2d');
    ctx2 = canvas2.getContext('2d');
    camera = new Camera(10, 30);
//    canvas.width  = Camera.width;
//    canvas.height = Camera.height;
    world = new World('first');
  }

  void runWhenReady() {
    Future.wait(world.ready()).then((_) {
//      canvas.width  = map.getWidth();
//      canvas.height = map.getHeight();
      window.requestAnimationFrame(renderLoop);
    });
  }

  void renderLoop(double time) {
    moves();
    camera.draw(world);
    window.requestAnimationFrame(renderLoop);
  }

  void moves() {
    var directions = { 'x': 0, 'y': 0 };
    if (keyboard.isPressed(KeyCode.W)) directions['y'] = -1;
    if (keyboard.isPressed(KeyCode.D)) directions['x'] = 1;
    if (keyboard.isPressed(KeyCode.S)) directions['y'] = 1;
    if (keyboard.isPressed(KeyCode.A)) directions['x'] = -1;

    if (keyboard.areNotPressed([KeyCode.W, KeyCode.D, KeyCode.S, KeyCode.A])) {
      world.player.animationState = -1;
    }

    world.player.move(directions, world.map);
    camera.track(world.player);
  }
}