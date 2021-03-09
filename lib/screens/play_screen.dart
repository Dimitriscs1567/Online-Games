import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/utils/storage.dart';
import 'package:online_games/widgets/playground.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:vrouter/vrouter.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String gameTitle =
        VRouteData.of(context).pathParameters["game"] ?? "";
    final String creator =
        VRouteData.of(context).pathParameters["creator"] ?? "";

    return ScreenWrapper(
      appbarTitle: gameTitle,
      noConstraints: true,
      withAuthentication: true,
      child: FutureBuilder<String?>(
        future: Storage.getValue(Storage.BOARD_PASS),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          return StreamBuilder(
            stream: Socket.getStream(Message.getBoard(creator, snapshot.data))
                .where((event) => _filterStream(event, creator)),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return _getWidgetFromState(json.decode(snapshot.data.toString()));
            },
          );
        },
      ),
    );
  }

  Widget _getWidgetFromState(dynamic state) {
    switch (state["type"]) {
      case "Error":
        return _errorBody(state["body"]["error"]);
      case "BoardState":
        return Playground(state: state["body"]["board"]);
      default:
        return _errorBody("This should never happen");
    }
  }

  Widget _errorBody(String error) {
    return Center(
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  bool _filterStream(dynamic event, String gameCreator) {
    final type = json.decode(event)["type"] as String;
    if (type.compareTo("BoardState") != 0 && type.compareTo("Error") != 0) {
      return false;
    }

    if (type.compareTo("BoardState") == 0) {
      final creator = json.decode(event)["body"]["board"]["creator"] as String;
      if (creator.compareTo(gameCreator) != 0) {
        return false;
      }
    }

    return true;
  }
}
