import 'package:flame/components.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:forge2d/forge2d.dart';

import '../controllers/generate_ball.dart';
import '../tools/size_tool.dart';
import 'game_init.dart';
import 'game_onload.dart';
//HasTapableComponents处理点击事件
//单次游戏的主类
class MyGame extends Forge2DGame with HasTapableComponents {
  MyGame(
    double width,
    double height, {
    this.hide,
  }) {
    hide ??= false;
    final viewportSize = Vector2(width, height);
    //对游戏做一些简单的初始化
    GameInit(this).init(viewportSize);
  }

  bool hide;

  @override
  Future<void> onLoad() async {
    await GameOnload(this).onLoad();
  }

  @override
  void onTapDown(_, TapDownDetails details) {
    if (hide) return;
    super.onTapDown(_, details);
    if (details.localPosition.dy > viewport.vw(30)) {
      GenerateBall(this).generateBall(details.localPosition.dx);
    }
  }

  @override
  void update(double dt) {
    if (hide) return;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    if (hide) return;
    super.render(canvas);
  }
}
