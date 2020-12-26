import 'package:flutter/material.dart';
import 'package:online_games/utils/api.dart';

class Playground extends StatefulWidget {
  late final dynamic state;

  Playground({@required this.state});

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _bottomPlayer(),
      ],
    );
  }

  Widget _bottomPlayer() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.filled(
              10,
              Image.network(
                API.BASIC_URL + "/assets/games/Tichu/cardCover.png",
                width: 100,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
