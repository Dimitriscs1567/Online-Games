import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_games/utils/custom_router.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameSelectionScreen extends StatelessWidget {
  final cRouter = CustomRouter();

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
              future: _getGames(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.isEmpty) {
                      return _emptyBody();
                    }
                    return _gamesBody(snapshot.data.docs);
                  } else {
                    return _errorBody();
                  }
                }
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

  Widget _gamesBody(List<DocumentSnapshot> games) {
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
                              .navigateTo(context, "/${game.id}/rooms");
                        },
                        child: Image.asset(
                          game.data()["image"],
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

  Future<QuerySnapshot> _getGames(BuildContext context) {
    if (FirebaseAuth.instance.currentUser() == null) {
      cRouter.router.navigateTo(context, "/login");
    }

    Firestore db = firestore();
    return db.collection("games").get();
  }
}
