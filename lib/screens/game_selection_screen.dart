import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GameSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
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
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: Text("Tichu"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
