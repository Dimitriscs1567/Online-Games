import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/game_controller.dart';
import 'package:online_games/models/Game.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appbarTitle: "All Games",
      child: GetX<GameController>(
        init: GameController(),
        builder: (controller) {
          if (!controller.isInitiallized.value!) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.allGames.isEmpty) {
              return _emptyBody();
            } else {
              return _gamesBody(controller.allGames);
            }
          }
        },
      ),
    );
  }

  Widget _emptyBody() {
    return Center(
      child: Text(
        "No games found!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _gamesBody(List<Game> games) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 30.0,
        scrollDirection: Axis.vertical,
        childAspectRatio: 0.67,
        children: games
            .map(
              (game) => Center(
                child: InkWell(
                  onTap: () => Get.toNamed("/${game.title}/boards"),
                  child: Image.network(
                    game.image,
                    fit: BoxFit.fill,
                    width: 200,
                    height: 300,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
