import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/widgets/other_player_widget.dart';
import 'package:online_games/widgets/play_table_widget.dart';
import 'package:online_games/widgets/playerWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Playground extends StatelessWidget {
  late final dynamic state;
  late final int position;
  late final bool isJoined;

  Playground({@required this.state}) {
    print(state.toString());
    final controller = Get.find<AuthController>();

    position =
        (state["state"])["players"].indexOf(controller.user.value!.username);
    isJoined = position > -1;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> otherPlayers = [];
    for (int i = 0; i < state["capacity"]; i++) {
      if (i != position) {
        AlignmentGeometry alignment;
        int distance = i - position;
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
          position: i,
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
            isJoined
                ? PlayerWidget(
                    state: state,
                    position: position,
                  )
                : Container(),
            ...otherPlayers,
            isJoined
                ? PlayTableWidget(
                    state: state,
                    position: position,
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
