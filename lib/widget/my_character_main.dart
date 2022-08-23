import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:savemymoney/widget/main_my_character.dart';

class MyGame extends FlameGame with HasGameRef {
  SpriteComponent myCharacterCp = SpriteComponent();
  SpriteComponent bgFarmComponent = SpriteComponent();
  late MyCharacter _myCharacter;

  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void> onLoad() async {
    bgFarmComponent
      ..sprite = await loadSprite('bg_farm.png')
      ..size = Vector2(size[0], size[1])
      ..anchor = Anchor.centerRight
      ..x = size[0]
      ..y = size[1] / 2;

    myCharacterCp
      ..sprite = await loadSprite('chicken.png')
      ..size = Vector2(50, 50)
      ..anchor = Anchor.centerRight
      ..x = size[0] / 2
      ..y = size[1] / 2;

    _myCharacter = MyCharacter();
    _myCharacter.position = Vector2(size[0] / 2, size[1] / 1.5);

    add(bgFarmComponent);
    add(myCharacterCp);
    add(_myCharacter);
  }
}
