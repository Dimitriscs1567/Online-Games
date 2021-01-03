import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/widgets/other_player_widget.dart';
import 'package:online_games/widgets/playerWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Playground extends StatelessWidget {
  late final dynamic state;
  late final int playerNumber;
  late final bool isJoined;

  Playground({@required this.state}) {
    print(state.toString());
    final controller = Get.find<AuthController>();

    playerNumber = (state["states"].last)["players"]
        .indexOf(controller.user.value.username);
    isJoined = playerNumber > -1;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> otherPlayers = [];
    for (int i = 0; i < state["capacity"]; i++) {
      if (i != playerNumber) {
        AlignmentGeometry alignment;
        int distance = i - playerNumber;
        if (distance < 0) {
          distance += state["capacity"] as int;
        }

        switch (distance) {
          case 1:
            alignment = Alignment.centerLeft;
            break;
          case 2:
            alignment = Alignment.topCenter;
            break;
          case 3:
            alignment = Alignment.centerRight;
            break;
          default:
            alignment = Alignment.bottomCenter;
            break;
        }

        otherPlayers.add(OtherPlayerWidget(
          state: state,
          playerNumber: i,
          alignment: alignment,
          isJoined: isJoined,
        ));
      }
    }

    return ResponsiveBuilder(builder: (context, _) {
      return Container(
        color: Colors.green[200],
        child: Stack(
          children: [
            isJoined ? PlayerWidget(state: state) : Container(),
            ...otherPlayers,
          ],
        ),
      );
    });
  }
}
