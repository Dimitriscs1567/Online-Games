import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/utils/api.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Playground extends StatefulWidget {
  late final dynamic state;

  Playground({@required this.state});

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    print(widget.state);

    return ResponsiveBuilder(builder: (context, _) {
      return Stack(
        children: [
          _bottomPlayer(),
        ],
      );
    });
  }

  Widget _bottomPlayer() {
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
            alignment: Alignment.centerLeft,
            child: Text(
              controller.user.value.username,
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0)),
          Row(
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
        ],
      ),
    );
  }
}
