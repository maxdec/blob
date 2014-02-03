library blob;

import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;
import 'dart:math';

part 'game.dart';
part 'map.dart';
part 'tileset.dart';
part 'character.dart';
part 'keyboard.dart';
part 'sprite_handler.dart';
part 'world.dart';
part 'camera.dart';
part 'math.dart';

void main() {
  new Game().runWhenReady();
}
