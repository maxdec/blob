part of blob;

class Keyboard {
  Map<int, int> _keys = new Map<int, int>();

  Keyboard() {
    window.onKeyDown.listen((KeyboardEvent e) {
      if (!_keys.containsKey(e.keyCode)) _keys[e.keyCode] = e.timeStamp;
    });

    window.onKeyUp.listen((KeyboardEvent e) {
      _keys.remove(e.keyCode);
    });
  }

  bool isPressed(int keyCode) => _keys.containsKey(keyCode);
  bool isNotPressed(int keyCode) => !_keys.containsKey(keyCode);

  // Returns true if ALL are pressed
  bool arePressed(List<int> keyCodes) {
    for (final code in keyCodes) {
      if (isNotPressed(code)) return false;
    }
    return true;
  }

  // Returns true if ALL are NOT pressed
  bool areNotPressed(List<int> keyCodes) {
    for (final code in keyCodes) {
      if (isPressed(code)) return false;
    }
    return true;
  }
}