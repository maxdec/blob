part of blob;

class World {
  GameMap map;
  Character player;
  List<Character> characters;

  World(String mapName) {
    map = new GameMap(mapName);
    characters = [new Character('perso1', 130, 130, DIRECTION['LEFT'])];
    player = new Character('perso1', 100, 100, DIRECTION['DOWN']);
  }

  List<Future> ready() {
    return [map.ready(), player.ready()]
      ..addAll(characters.map((Character c) {
        return c.ready();
      }));
  }

  void addCharacter(Character char) {
    characters.add(char);
  }
}