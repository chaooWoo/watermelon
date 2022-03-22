import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'tools/navigator_tool.dart';
import 'tools/system_tool.dart';

void main() async {
  runApp(MyApp());
  //设置应用的屏幕方向
  SystemTool.keepPortrait();
}

// 学习flame制作游戏 【start】
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '合成大瓜',
      //添加路由监控工具，主要是页面跳转的动画设置
      navigatorObservers: [NavigatorTool()],
      //进入主页面
      home: HomePage(),
    );
  }
}
