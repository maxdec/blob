part of blob;

class GameEntity extends MutableRectangle {
  GameEntity([num left = 0, num top = 0, num width = 0, num height = 0]) : super(left, top, width, height);

  factory GameEntity.clone(Rectangle rect) {
    return new GameEntity(rect.left, rect.top, rect.width, rect.height);
  }

  void updateFrom(Rectangle rect) {
    top = rect.top;
    left = rect.left;
    width = rect.width;
    height = rect.height;
  }

  num get halfWidth => width / 2;
  num get halfHeight => height / 2;

  num get centerX => left + halfWidth;
  set centerX(num x) => left = x  - (width / 2);

  num get centerY => top + halfHeight;
  set centerY(num y) => top = y - (height / 2);

  void setCenter(Point center) {
    centerX = center.x;
    centerY = center.y;
  }

  Point getCenter() => new Point(top + halfWidth, left + halfHeight);
}