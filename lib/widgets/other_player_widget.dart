import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/api.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/utils/storage.dart';

class OtherPlayerWidget extends StatelessWidget {
  late final dynamic state;
  late final int? playerNumber;
  late final AlignmentGeometry? alignment;
  late final bool? isJoined;

  OtherPlayerWidget({
    @required this.state,
    @required this.playerNumber,
    @required this.alignment,
    @required this.isJoined,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = Get.width <= 1200 ? Get.width : 1200;
    final double cardWidth = (maxWidth / 14) - 4;

    return Container(
      alignment: alignment,
      child: RotatedBox(
        quarterTurns: _getAngleFromAlignment(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _nameWidget(),
            _cardsWidget(cardWidth),
          ],
        ),
      ),
    );
  }

  int _getAngleFromAlignment() {
    if (alignment == Alignment.centerLeft) {
      return 1;
    }

    if (alignment == Alignment.topCenter) {
      return 2;
    }

    if (alignment == Alignment.centerRight) {
      return 3;
    }

    return 0;
  }

  Widget _nameWidget() {
    final String? name = (state["states"].last)["players"][playerNumber];
    final bool hasStarted = state["started"];

    if (hasStarted && name != null) {
      return RotatedBox(
        quarterTurns: _getAngleFromAlignment() == 2 ? 2 : 0,
        child: Text(
          name,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      );
    } else if (name != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Padding(padding: const EdgeInsets.all(5.0)),
          isJoined! ? Container() : _seatButton(),
        ],
      );
    } else {
      return _seatButton();
    }
  }

  Widget _cardsWidget(double cardWidth) {
    final bool visible = state["started"];

    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2.0,
              vertical: 12.0,
            ),
            child: Image.network(
              API.BASIC_URL + "/assets/games/Tichu/cardCover.png",
              width: cardWidth,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget _seatButton() {
    return RotatedBox(
      quarterTurns: _getAngleFromAlignment() == 2 ? 2 : 0,
      child: ElevatedButton(
        child: Text(isJoined! ? "Change seat" : "Join"),
        onPressed: () {
          if (!isJoined!) {
            final String creator = state["creator"];
            final String password = Storage.getValue(Storage.BOARD_PASS);

            Socket.sendMessage(
                Message.joinBoard(creator, playerNumber!, password));
          }
        },
      ),
    );
  }
}
