import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final bool withFloatingButton;
  final String appbarTitle;

  ScreenWrapper({
    @required this.child,
    @required this.withFloatingButton,
    @required this.appbarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
        centerTitle: true,
      ),
      floatingActionButton: Offstage(
        offstage: !withFloatingButton,
        child: FloatingActionButton.extended(
          label: Text("Create room"),
          icon: Icon(
            Icons.add,
            size: 35.0,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          child: child,
        ),
      ),
    );
  }
}
