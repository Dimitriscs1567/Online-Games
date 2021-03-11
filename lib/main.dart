import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_games/screens/board_selection_screen.dart';
import 'package:online_games/screens/game_selection_screen.dart';
import 'package:online_games/screens/play_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vrouter/vrouter.dart';

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
    return VRouter(
      debugShowCheckedModeBanner: false,
      routes: [
        VStacked(path: '/games', widget: GameSelectionScreen()),
        VStacked(path: '/:game/boards', widget: BoardSelectionScreen()),
        VStacked(path: '/:game/play/:creator', widget: PlayScreen()),
        VRouteRedirector(path: ':_(.*)', redirectTo: '/games'),
      ],
      title: 'Online Games',
    );
  }
}
