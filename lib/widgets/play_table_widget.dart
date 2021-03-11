import 'package:flutter/material.dart';
import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/utils/storage.dart';

class PlayTableWidget extends StatelessWidget {
  late final dynamic state;
  late final int? position;

  PlayTableWidget({
    @required this.state,
    @required this.position,
  });

  @override
  Widget build(BuildContext context) {
    if (!state["started"]) {
      final bool ready = state["state"]["readyPlayers"][position];

      return Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ready ? Colors.red : Colors.green)),
          child: Text(ready ? "Not ready" : "Ready"),
          onPressed: () {
            Socket.sendMessage(Message.playerReady(
              state["creator"],
              Storage.getValue(Storage.BOARD_PASS),
            ));
          },
        ),
      );
    }

    return Container();
  }
}
