part of blob;

const ANIMATION_LENGTH = 4;
const MOVEMENT_LENGTH = 15;

class Character {
  String name;
  num x, y, direction, width, height;
  ImageElement image;
  num animationState;

  Character(String name, num x, num y, num direction) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.direction = direction;
    animationState = -1; // < 0 == static character

    image = new ImageElement()
      ..src = 'sprites/$name.png';
  }

  Future ready() {
    return image.onLoad.first.then((_) {
      width = image.width / 4;
      height = image.height / 4;
    });
  }

  void drawCharacter() {
    var frame = 0, dx = 0, dy = 0;
    if (animationState >= MOVEMENT_LENGTH) {
      animationState = -1;
    } else if (animationState >= 0) {
      frame = (animationState ~/ ANIMATION_LENGTH) % 4;
      var pixelsToGo = 32 - (32 * animationState / MOVEMENT_LENGTH);
      if (direction == DIRECTION['UP']) {
        dy = pixelsToGo;
      } else if (direction == DIRECTION['DOWN']) {
        dy = -pixelsToGo;
      } else if (direction == DIRECTION['LEFT']) {
        dx = pixelsToGo;
      } else if (direction == DIRECTION['RIGHT']) {
        dx = -pixelsToGo;
      }
      animationState++;
    }
    ctx.drawImageScaledFromSource(
      image,
      width * frame, direction * height, // Point d'origine du rectangle source à prendre dans notre image
      width, height, // Taille du rectangle source (c'est la taille du personnage)
      (x * 32) - (width / 2) + 16 + dx, (y * 32) - height + 24 + dy, // Point de destination (dépend de la taille du personnage)
      width, height // Taille du rectangle destination (c'est la taille du personnage)
    );
  }

  Map getAdjCoords(num direction) {
    var coords = { 'x': x, 'y': y };
    if (direction == DIRECTION['UP']) {
      coords['y']--;
    } else if (direction == DIRECTION['DOWN']) {
      coords['y']++;
    } else if (direction == DIRECTION['LEFT']) {
      coords['x']--;
    } else if (direction == DIRECTION['RIGHT']) {
      coords['x']++;
    }
    return coords;
  }

  bool move(num direction, GameMap map) {
    // Don't move if a move is already in process
    if (animationState >= 0) return false;

    this.direction = direction;

    var nextPos = getAdjCoords(direction);
    if (nextPos['x'] < 0 || nextPos['y'] < 0 ||
        nextPos['x'] >= map.getWidth() || nextPos['y'] >= map.getHeight()) {
      animationState = -1;
      return false;
    }

    animationState = 1; // mobile
    x = nextPos['x'];
    y = nextPos['y'];
    return true;
  }

}