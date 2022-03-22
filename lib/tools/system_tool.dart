import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemTool {
  static void changeStatusBarColor([Color color]) {
    //设置状态栏的颜色/深色模式
    color ??= Colors.white;
    final style = SystemUiOverlayStyle(
      statusBarColor: color,
      systemNavigationBarDividerColor: null,
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static void keepPortrait() {
    //设置屏幕方向为竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
