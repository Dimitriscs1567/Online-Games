import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BoardSelectionScreen extends StatelessWidget {
  final String game = Get.parameters["game"];

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      withAuthentication: true,
      appbarTitle: "$game Boards",
      floatingButton: FloatingActionButton.extended(
        label: Text("Create room"),
        icon: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () {},
      ),
      child: GridView.extent(
        maxCrossAxisExtent: 400,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 30.0,
        crossAxisSpacing: 30.0,
        childAspectRatio: 1.3,
        children: [].map((room) {
          Color bgColor =
              (room["currentPlayers"] as int) == (room["totalPlayers"] as int)
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
                      room["name"],
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "by ${room["host"]}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      "Players: ${room["currentPlayers"]} out of ${room["totalPlayers"]}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
