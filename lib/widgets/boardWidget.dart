import 'package:flutter/material.dart';
import 'package:online_games/models/Board.dart';

class BoardWidget extends StatelessWidget {
  late final Board? board;
  late final Function? onPress;

  BoardWidget({@required this.board, this.onPress});

  @override
  Widget build(BuildContext context) {
    Color? bgColor = board!.isFull() ? Colors.red[200] : Colors.blue[200];

    return Container(
      width: 350,
      child: InkWell(
        onTap: onPress != null ? () => onPress!() : null,
        child: Card(
          color: bgColor,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  board!.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: const EdgeInsets.all(8.0)),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            board!.getPlayersText(),
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                          Text(
                            board!.created,
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "By " + board!.creator,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
