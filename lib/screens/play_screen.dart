import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class PlayScreen extends StatelessWidget {
  final String _gameTitle = Get.parameters["game"] ?? "";
  final String _creator = Get.parameters["creator"] ?? "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: ScreenWrapper(
        appbarTitle: _gameTitle,
        child: StreamBuilder(
          stream: Socket.getStream(Message.getBoard(_creator)),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Center(
              child: Text(snapshot.data.toString()),
            );
          },
        ),
      ),
    );
  }
}
