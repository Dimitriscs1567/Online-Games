import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_games/screens/board_selection_screen.dart';
import 'package:online_games/screens/game_selection_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> main() async {
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 1000, tablet: 700, watch: 200),
  );
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/games',
      getPages: [
        GetPage(name: '/games', page: () => GameSelectionScreen()),
        GetPage(name: '/:game/boards', page: () => BoardSelectionScreen()),
      ],
      title: 'Online Games',
    );
  }
}
