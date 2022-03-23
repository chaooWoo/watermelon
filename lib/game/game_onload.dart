import '../components/background.dart';
import '../components/dead_line.dart';
import '../components/scores.dart';
import '../components/setting_button.dart';
import '../controllers/generate_ball.dart';
import '../controllers/update_balls_bounce.dart';
import '../controllers/update_balls_falling.dart';
import '../controllers/update_dead_line.dart';
import '../controllers/update_gravity.dart';
import '../controllers/update_level_up.dart';
import '../tools/audio_tool.dart';
import '../tools/image/image_tool.dart';
import 'game_state.dart';
import 'level/levels.dart';
import 'my_game.dart';
//游戏加载
class GameOnload {
  MyGame gameRef;
  GameOnload(this.gameRef);

  static bool inited = false;

  static Future<void> init() async {
    //游戏状态、配置初始化
    await GameState.init();
    await Levels.init();
    if (inited) return;
    //图片资源加载
    await ImageTool.loadAll();
    //音频资源加载
    await AudioTool.loadAll();
    inited = true;
  }

  ///初始化
  Future<void> onLoad() async {
    await init();

    ///使用MyGame(父类)的add方法，将组件都添加到游戏中
    ///应该是按照添加的顺序在z轴上叠加的??

    final background = Background.create(gameRef.viewport);
    await gameRef.add(background);
    final deadLine = DeadLine.create(gameRef.viewport);
    await gameRef.add(deadLine);
    GameState.scoreComponent =
        Scores.create(gameRef.viewport, text: GameState.score.toString());
    await gameRef.add(GameState.scoreComponent);
    final settingButton = SettingButton.create(gameRef.viewport);
    await gameRef.add(settingButton);
    await GenerateBall(gameRef).generateBall();
    //初始化 game controllers
    await gameRef.add(UpdateBallsFalling());
    await gameRef.add(UpdateBallsBounce());
    await gameRef.add(UpdateLevelUp());
    await gameRef.add(UpdateDeadLine());
    await gameRef.add(UpdateGravity());
  }
}
