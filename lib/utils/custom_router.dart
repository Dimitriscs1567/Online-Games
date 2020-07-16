import 'package:fluro/fluro.dart';
import 'package:online_games/screens/game_selection_screen.dart';
import 'package:online_games/screens/login_screen.dart';
import 'package:online_games/screens/room_selection_screen.dart';

class CustomRouter {
  final router = Router();

  static final _customRouter = CustomRouter._internal();

  CustomRouter._internal() {
    router.define(
      "/login",
      handler: Handler(
        handlerFunc: (context, parameters) {
          return LoginScreen();
        },
      ),
    );
    router.define(
      "/games",
      handler: Handler(
        handlerFunc: (context, parameters) {
          return GameSelectionScreen();
        },
      ),
    );
    router.define(
      "/:game/rooms",
      handler: Handler(
        handlerFunc: (context, parameters) {
          return RoomSelectionScreen(
            game: parameters["game"][0],
          );
        },
      ),
    );
  }

  factory CustomRouter() {
    return _customRouter;
  }
}
