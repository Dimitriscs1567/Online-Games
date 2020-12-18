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
            stream: Socket.channel.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              return GridView.extent(
                maxCrossAxisExtent: 400,
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 30.0,
                crossAxisSpacing: 30.0,
                childAspectRatio: 1.3,
                children: [json.decode(snapshot.data)].map((board) {
                  int numOfPlayers = board["otherPlayers"].length;
                  int maxCapacity = board["maxCapacity"] as int;

                  Color? bgColor = numOfPlayers == maxCapacity - 1
                      ? Colors.red[200]
                      : Colors.blue[200];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Card(
                          color: bgColor,
                          child: ListTile(
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
                            subtitle: Text(
                              "Players: ${numOfPlayers + 1} out of $maxCapacity",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
