import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/models/Game.dart';
import 'package:online_games/utils/api.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withAuthentication: false,
      floatingButton: null,
      appbarTitle: "All Games",
      child: FutureBuilder(
        future: API.getAllGames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              if ((snapshot.data as List).isEmpty) {
                return _emptyBody();
              }
              return _gamesBody(snapshot.data as List<Game>);
            } else {
              return _errorBody();
            }
          }
        },
      ),
    );
  }

  Widget _errorBody() {
    return Center(
      child: Text(
        "An error has occured!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
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
                  onTap: () => Get.toNamed("/games/${game.title}/boards"),
                  child: Image.network(
                    API.BASIC_URL + "/" + game.image,
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
