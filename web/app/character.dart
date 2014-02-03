part of blob;

const ANIMATION_LENGTH = 4;
const MOVEMENT_SPEED = 36;
const DX = 4;

class Character extends GameEntity {
  String name;
  num x, y, width, height, direction;
  SpriteHandler spriteh;
  num animationState;

  Character(this.name, this.x, this.y, this.direction) {
    animationState = -1; // < 0 == static character
    spriteh = new SpriteHandler(name);
  }

  Future ready() => spriteh.ready().then((_) {
    width = spriteh.spriteMap['properties']['dx'];
    height = spriteh.spriteMap['properties']['dy'];
  });

  void draw() {
    var frame = 0;
    if (animationState >= MOVEMENT_SPEED) {
      // Limit the animation speed
      animationState = -1;
    } else if (animationState >= 0) {
      frame = (animationState ~/ ANIMATION_LENGTH) % 4;
      animationState++;
    }
    spriteh.draw(ctx, x, y, 'directions', direction, frame);
  }

  Map getNextCoords(Map directions) {
    var coords = { 'x': x, 'y': y };
    coords['x'] += directions['x'] * DX;
    coords['y'] += directions['y'] * DX;
    return coords;
  }

  bool move(Map directions, GameMap map) {
    var nox, noy;

    // UGLY direction detection
    if (directions['x'] != 0) { direction = directions['x'] % 4; }
    else if (directions['y'] == -1) { direction = 0; }
    else if (directions['y'] == 1) { direction = 2; }
    // else { keep the previous one }

    var nextPos = getNextCoords(directions);
    nox = nextPos['x'] < 0 || nextPos['x'] + width > map.getWidth();
    noy = nextPos['y'] < 0 || nextPos['y'] + height > map.getHeight();

    if (nox && noy) {
      animationState = -1;
      return false;
    }

    if (!nox) x = nextPos['x'];
    if (!noy) y = nextPos['y'];
    return true;
  }

}