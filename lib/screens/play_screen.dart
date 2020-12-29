import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/widgets/playground.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class PlayScreen extends StatelessWidget {
  final String _gameTitle = Get.parameters["game"] ?? "";
  final String _creator = Get.parameters["creator"] ?? "";
  final String? _password = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appbarTitle: _gameTitle,
      noConstraints: true,
      withAuthentication: true,
      child: StreamBuilder(
        stream: Socket.getStream(Message.getBoard(_creator, _password)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return _getWidgetFromState(json.decode(snapshot.data.toString()));
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
}
