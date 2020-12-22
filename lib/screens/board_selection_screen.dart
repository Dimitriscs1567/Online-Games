import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/game_controller.dart';
import 'package:online_games/models/Board.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/widgets/boardWidget.dart';
import 'package:online_games/widgets/dialogs/create_board_dialog.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class BoardSelectionScreen extends StatelessWidget {
  final String _gameTitle = Get.parameters["game"] ?? "";

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withAuthentication: true,
      appbarTitle: "$_gameTitle Boards",
      floatingButton: FloatingActionButton.extended(
        label: Text("Create board"),
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreateBoardDialog(),
          );
        },
      ),
      child: GetX<GameController>(
        init: GameController(),
        builder: (controller) {
          if (!controller.isInitiallized.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.isInitiallized.value &&
              controller.selectedGame.value.title.isEmpty) {
            controller.changeSelectedGame(_gameTitle);
          }

          if (!controller.selectedGameExists.value) {
            return _errorBody();
          }

          return StreamBuilder<dynamic>(
            stream: Socket.getChannel(_gameTitle).stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final type = json.decode(snapshot.data)["type"] as String;
              if (type.compareTo("Boards") != 0) {
                return Center(child: CircularProgressIndicator());
              }

              final boards =
                  json.decode(snapshot.data)["body"]["boards"] as List<dynamic>;

              if (boards.isEmpty) {
                return _emptyBody();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: GridView.extent(
                  maxCrossAxisExtent: 350,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 2.0,
                  children: boards.map((boardMap) {
                    final board = Board.fromMap(boardMap);

                    return Center(
                      child: BoardWidget(board: board),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _errorBody() {
    return Center(
      child: Text(
        "Game not found!",
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
        "No boards found!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
