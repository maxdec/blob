part of blob;

class Character {
  String name;
  num x, y, direction, width, height;
  ImageElement image;

  Character(String name, num x, num y, num direction) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.direction = direction;

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
    print(direction);
    ctx.drawImageScaledFromSource(
      image,
      0, direction * height, // Point d'origine du rectangle source à prendre dans notre image
      width, height, // Taille du rectangle source (c'est la taille du personnage)
      (x * 32) - (width / 2) + 16, (y * 32) - height + 24, // Point de destination (dépend de la taille du personnage)
      width, height // Taille du rectangle destination (c'est la taille du personnage)
    );
  }
}