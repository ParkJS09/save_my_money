import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'dart:developer' as dev;

import 'package:savemymoney/widget/my_character_main.dart';

enum CharacterMove { LEFT, STASH, RIGHT }

class MyCharacter extends SpriteAnimationComponent with HasGameRef<MyGame> {
  MyCharacter({this.myCharacter = 'tutorial.png'})
      : super(size: Vector2.all(50));

  CharacterMove characterMove = CharacterMove.RIGHT;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runRightAnimation;
  late SpriteSheet spriteSheet;
  late String myCharacter;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations();
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(myCharacter),
      srcSize: Vector2(29, 32),
    );

    _runLeftAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 3,
    );

    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 3,
    );
    //초기 애니메이션 값 세팅 (여기선 오른쪽으로 이동하니 오른쪽 애니메이션 설정)
    animation = _runRightAnimation;
  }

  @override
  void update(double dt) {
    //animation의 update()를 호출하여 애니메이션의 업데이트
    animation?.update(dt);
    if (position.x <= gameRef.size.x * 0.25) {
      onMove(CharacterMove.RIGHT);
    }

    if (position.x > gameRef.size.x * 0.75) {
      onMove(CharacterMove.LEFT);
    }

    switch (characterMove) {
      case CharacterMove.LEFT:
        position.x -= 1;
        break;
      case CharacterMove.RIGHT:
        position.x += 1;
        break;
      case CharacterMove.STASH:
        break;
    }
  }

  void onMove(CharacterMove move) {
    characterMove = move;
    switch (characterMove) {
      case CharacterMove.LEFT:
        animation = _runLeftAnimation;
        break;
      case CharacterMove.RIGHT:
        animation = _runRightAnimation;
        break;
      case CharacterMove.STASH:
        break;
    }
  }
}
