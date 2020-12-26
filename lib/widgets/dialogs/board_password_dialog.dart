import 'package:flutter/material.dart';

class BoardPasswordDialog extends StatefulWidget {
  @override
  _BoardPasswordDialogState createState() => _BoardPasswordDialogState();
}

class _BoardPasswordDialogState extends State<BoardPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Board Password",
        textAlign: TextAlign.center,
      ),
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value != null && value.trim().isEmpty) {
                        return 'Please enter a password';
                      }

                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 20.0,
                      )),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          _controller.text.trim(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
