import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/screens/board_selection_screen.dart';
import 'package:online_games/screens/game_selection_screen.dart';
import 'package:online_games/screens/login_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/games',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/games', page: () => GameSelectionScreen()),
        GetPage(
            name: '/games/:game/boards', page: () => BoardSelectionScreen()),
      ],
      title: 'Online Games',
    );
  }
}
