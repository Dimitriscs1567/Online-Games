import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/widgets/other_player_widget.dart';
import 'package:online_games/widgets/playerWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Playground extends StatelessWidget {
  late final dynamic state;
  late final int playerNumber;
  late final String playerName;
  List<int> otherPlayesNumbers = [];

  Playground({@required this.state}) {
    print(state.toString());
    final controller = Get.find<AuthController>();

    playerNumber = (state["states"].last)["players"]
        .indexOf(controller.user.value.username);
    playerName = (state["states"].last)["players"][playerNumber];

    for (int i = 0; i < state["capacity"]; i++) {
      if (i != playerNumber) {
        otherPlayesNumbers.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> otherPlayers = [];
    for (int i = 0; i < otherPlayesNumbers.length; i++) {
      AlignmentGeometry alignment;
      switch (i) {
        case 0:
          alignment = Alignment.centerLeft;
          break;
        case 1:
          alignment = Alignment.topCenter;
          break;
        case 2:
          alignment = Alignment.centerRight;
          break;
        default:
          alignment = Alignment.bottomCenter;
          break;
      }

      otherPlayers.add(OtherPlayerWidget(
        state: state,
        playerNumber: otherPlayesNumbers[i],
        alignment: alignment,
      ));
    }

    return ResponsiveBuilder(builder: (context, _) {
      return Container(
        color: Colors.green[200],
        child: Stack(
          children: [
            PlayerWidget(state: state),
            ...otherPlayers,
          ],
        ),
      );
    });
  }
}
