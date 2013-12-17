library blob;

import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

part 'game.dart';
part 'map.dart';
part 'tileset.dart';
part 'character.dart';

void main() {
  new Game().runWhenReady();
}
