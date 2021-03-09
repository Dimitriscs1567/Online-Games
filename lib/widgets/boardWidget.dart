import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/models/Board.dart';
import 'package:online_games/utils/storage.dart';
import 'package:online_games/widgets/dialogs/board_password_dialog.dart';

class BoardWidget extends StatelessWidget {
  late final Board? board;
  late final bool _hasPassword;

  BoardWidget({@required this.board}) {
    final controller = Get.find<AuthController>();

    _hasPassword = board!.password.isNotEmpty &&
        board!.creator.compareTo(controller.user.value!.username) != 0;
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = board!.isFull() ? Colors.red[200] : Colors.blue[200];
    final List<Widget> header = !_hasPassword
        ? [
            Text(
              board!.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
        : [
            Text(
              board!.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: const EdgeInsets.all(5.0)),
            Icon(
              Icons.lock,
              size: 22.0,
              color: Colors.red,
            ),
          ];

    return Container(
      width: 350,
      child: InkWell(
        onTap: board!.isFull()
            ? null
            : () async {
                if (_hasPassword) {
                  String? pass = await showDialog(
                    context: context,
                    builder: (context) => BoardPasswordDialog(),
                  );

                  if (pass != null) {
                    Storage.saveValue(Storage.BOARD_PASS, pass);

                    Get.toNamed("/${board!.gameTitle}/play/${board!.creator}");
                  }
                } else {
                  Get.toNamed("/${board!.gameTitle}/play/${board!.creator}");
                }
              },
        child: Card(
          color: bgColor,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: header,
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
