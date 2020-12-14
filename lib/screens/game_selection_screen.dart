import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/models/Game.dart';
import 'package:online_games/utils/api.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withFloatingButton: false,
      appbarTitle: "All Games",
      child: Expanded(
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
                if (snapshot.data.isEmpty) {
                  return _emptyBody();
                }
                return _gamesBody(snapshot.data);
              } else {
                return _errorBody();
              }
            }
          },
        ),
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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        int crossAxisCount;
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.desktop:
            crossAxisCount = 3;
            break;
          case DeviceScreenType.tablet:
            crossAxisCount = 2;
            break;
          default:
            crossAxisCount = 1;
            break;
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          scrollDirection: Axis.vertical,
          children: games
              .map(
                (game) => Container(
                  alignment: Alignment.center,
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
        );
      },
    );
  }
}
