import 'package:flutter/material.dart';

class NewBoardDialog extends StatefulWidget {
  @override
  _NewBoardDialogState createState() => _NewBoardDialogState();
}

class _NewBoardDialogState extends State<NewBoardDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Create new board"),
    );
  }
}
