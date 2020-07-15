import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_games/utils/custom_router.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameSelectionScreen extends StatelessWidget {
  final cRouter = CustomRouter();
  final games = List<Map>.filled(
    1,
    Map.from({
      "image": "assets/tichu/tichu-cover.png",
      "name": "tichu",
    }),
  );

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withFloatingButton: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "All Games",
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGames(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  print(snapshot.data.toString());
                  return _gamesBody();
                } else if (snapshot.hasError) {
                  return _errorBody();
                }

                return Container();
              },
            ),
          ),
        ],
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

  Widget _gamesBody() {
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
          childAspectRatio: 0.7,
          children: games
              .map((game) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          cRouter.router
                              .navigateTo(context, "/${game["name"]}/rooms");
                        },
                        child: Image.asset(
                          game["image"],
                          fit: BoxFit.fill,
                          width: 200,
                          height: 300,
                        ),
                      ),
                    ],
                  ))
              .toList(),
        );
      },
    );
  }

  Future<QuerySnapshot> _getGames() {
    fs.Firestore db = firestore();
    return db.collection("games").get();
  }
}
