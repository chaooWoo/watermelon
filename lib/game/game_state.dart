import '../components/ball.dart';
import '../components/scores.dart';
import '../game/game_setting.dart';
import '../tools/hive_tool.dart';
//记录游戏整体状态(最高纪录、游戏设置等)、单次游戏的开始/暂停及过程中的状态(本次游戏的分数、游戏状态等)
class GameState {
  ///成绩
  static int score = 0;

  ///最高纪录
  static int record = 0;

  ///是否是新纪录
  static bool isNewRecord = false;

  ///游戏状态
  static GameStatus gameStatus = GameStatus.start;

  ///游戏设置
  static GameSetting gameSetting = GameSetting();

  ///上一个小球
  static Ball lastBall;

  ///分数部件
  static Scores scoreComponent;

  //本地保存最高分数
  static Future<void> updateScore(int newScore) async {
    score = newScore;
    scoreComponent?.text = GameState.score.toString();
    if (newScore > record) {
      record = newScore;
      isNewRecord = true;
      await HiveTool().set<int>('record', score);
    }
  }

  //本地保存用户设置
  static Future<void> updateSetting(GameSetting setting) async {
    gameSetting = setting;
    await HiveTool().set<String>('gameSetting', gameSetting.toJsonStr());
  }

  static bool inited = false;

  ///重置游戏状态
  static Future<void> init() async {
    score = 0;
    isNewRecord = false;
    gameStatus = GameStatus.start;
    lastBall = null;
    await initSetting();
  }

  static Future<void> initSetting() async {
    if (inited) return;
    final n = await HiveTool().get<int>('record');
    if (n != null) record = n;
    final s = await HiveTool().get<String>('gameSetting');
    if (s != null) gameSetting = GameSetting.fromJsonStr(s);
    inited = true;
  }
}

///游戏状态
enum GameStatus {
  ///挂了
  over,

  ///赢了
  win,

  ///暂停
  pause,

  ///开始
  start,
}
