import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/widgets/screen_wrapper.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BoardSelectionScreen extends StatelessWidget {
  final String game = Get.parameters["game"];

  @override
  Widget build(BuildContext context) {
    final rooms = [
      {
        "totalPlayers": 4,
        "currentPlayers": 3,
        "name": "My Tichu",
        "host": "dimis",
        "id": 1,
      },
      {
        "totalPlayers": 4,
        "currentPlayers": 4,
        "name": "My Tichu 2",
        "host": "evgenios",
        "id": 2,
      },
    ];

    return ScreenWrapper(
      withFloatingButton: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Current ${game.toUpperCase()[0] + game.substring(1)} Rooms",
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                int crossAxisCount;
                switch (sizingInformation.deviceScreenType) {
                  case DeviceScreenType.desktop:
                    crossAxisCount = 3;
                    break;
                  case DeviceScreenType.tablet:
                    crossAxisCount = 2;
                    break;
                  default:
                    crossAxisCount = 1;
                    break;
                }

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 30,
                  childAspectRatio: 1.3,
                  children: rooms.map((room) {
                    Color bgColor = (room["currentPlayers"] as int) ==
                            (room["totalPlayers"] as int)
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
