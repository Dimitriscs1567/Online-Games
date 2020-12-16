import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BoardSelectionScreen extends StatelessWidget {
  final String game = Get.parameters["game"];
  final channel = WebSocketChannel.connect(
      Uri(scheme: "ws", host: "localhost", port: 8080, path: "/"));

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withAuthentication: true,
      appbarTitle: "$game Boards",
      floatingButton: FloatingActionButton.extended(
        label: Text("Create board"),
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () {},
      ),
      child: StreamBuilder<dynamic>(
          stream: channel.stream,
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
              children: [snapshot.data].map((board) {
                Color bgColor = (board["otherPlayers"].length as int) ==
                        (board["maxCapacity"] as int) - 1
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
                            "Players: ${board["otherPlayers"] + 1} out of ${board["maxCapacity"]}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}
