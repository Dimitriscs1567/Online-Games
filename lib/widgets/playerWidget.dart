import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/utils/api.dart';

class PlayerWidget extends StatelessWidget {
  late final dynamic state;

  PlayerWidget({@required this.state});

  @override
  Widget build(BuildContext context) {
    final double maxWidth = Get.width <= 1200 ? Get.width : 1200;
    final double cardWidth = (maxWidth / 14) - 4;
    final controller = Get.find<AuthController>();

    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8.0, left: 2.0),
            width: maxWidth,
            alignment: Alignment.centerLeft,
            child: Text(
              controller.user.value.username,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          _cardsWidget(cardWidth)
        ],
      ),
    );
  }

  Widget _cardsWidget(double cardWidth) {
    final bool visible = state["started"];

    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.filled(
          14,
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
        ),
      ),
    );
  }
}
