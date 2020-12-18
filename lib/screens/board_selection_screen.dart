import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/utils/socket.dart';
import 'package:online_games/widgets/screen_wrapper.dart';

class BoardSelectionScreen extends StatelessWidget {
  final String _game = Get.parameters["game"] ?? "";
  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withAuthentication: true,
      appbarTitle: "$_game Boards",
      floatingButton: FloatingActionButton.extended(
        label: Text("Create board"),
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () {},
      ),
      child: GetX<AuthController>(
        builder: (controller) {
          if (!controller.user.value.isLoggedIn()) {
            return Container();
          }

          return StreamBuilder<dynamic>(
            stream: Socket.getChannel(_game).stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final type = json.decode(snapshot.data)["type"] as String;
              if (type.compareTo("Boards") != 0) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: GridView.extent(
                  maxCrossAxisExtent: 400,
                  scrollDirection: Axis.vertical,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 2.3,
                  children: (json.decode(snapshot.data)["body"]["boards"]
                          as List<dynamic>)
                      .map((board) {
                    int numOfPlayers = board["otherPlayers"].length;
                    int maxCapacity = board["capacity"] as int;

                    Color? bgColor = numOfPlayers == maxCapacity - 1
                        ? Colors.red[200]
                        : Colors.blue[200];

                    return Center(
                      child: ListTile(
                        tileColor: bgColor,
                        onTap: () {},
                        title: Text(
                          board["title"],
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "by ${board["creator"]}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Players: ${numOfPlayers + 1} out of $maxCapacity",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Padding(padding: const EdgeInsets.all(4.0)),
                            Text(
                              "Created ${getCreatedMessage(board["createdAt"])} minutes ago",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String getCreatedMessage(String date) {
    var parsedDate = DateTime.parse(date);

    return DateTime.now().difference(parsedDate).inMinutes.toString();
  }
}
