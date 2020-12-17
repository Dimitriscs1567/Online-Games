import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/utils/storage.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BoardSelectionScreen extends StatefulWidget {
  @override
  _BoardSelectionScreenState createState() => _BoardSelectionScreenState();
}

class _BoardSelectionScreenState extends State<BoardSelectionScreen> {
  final String _game = Get.parameters["game"] ?? "";
  WebSocketChannel? _channel;
  AuthController _controller = Get.put(AuthController());

  @override
  void initState() {
    bool auth = Storage.getValue(Storage.TOKEN) != null;

    if (!auth) {
      GetStorage().listenKey(Storage.TOKEN, (value) {
        if (value != null && (value as String).isNotEmpty && _channel == null) {
          _channel = WebSocketChannel.connect(Uri.parse(
              "ws://localhost:8080/${Storage.getValue(Storage.TOKEN)}"));
        }
      });
    } else {
      _channel = WebSocketChannel.connect(
          Uri.parse("ws://localhost:8080/${Storage.getValue(Storage.TOKEN)}"));
    }

    super.initState();
  }

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
      child: _channel == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<dynamic>(
              stream: _channel!.stream,
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
            ),
    );
  }

  @override
  void dispose() {
    if (_channel != null) {
      _channel!.sink.close();
    }

    super.dispose();
  }
}
