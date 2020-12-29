import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/controllers/game_controller.dart';

class CreateBoardDialog extends StatefulWidget {
  @override
  _CreateBoardDialogState createState() => _CreateBoardDialogState();
}

class _CreateBoardDialogState extends State<CreateBoardDialog> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _passwordController = TextEditingController();
  final _capacityController = TextEditingController();
  final _controller = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    final textFields = _controller.selectedGame.value.capacity > 0
        ? [
            _textField("Title*"),
            _textField("Password"),
          ]
        : [
            _textField("Title*"),
            _textField("Password"),
            _textField("Capacity*"),
          ];

    return SimpleDialog(
      title: Text(
        "Create new board",
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
                  ...textFields,
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
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                    onPressed: _isLoading ? null : _onCreate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(String label) {
    return TextFormField(
      controller: _getControllerFromLabel(label),
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        labelText: label,
      ),
      obscureText: label.compareTo("Password") == 0,
      validator: (value) => _getValidatorFromLabel(label, value),
    );
  }

  TextEditingController _getControllerFromLabel(String label) {
    switch (label) {
      case 'Title*':
        return _titleController;

      case "Password":
        return _passwordController;

      case "Capacity*":
        return _capacityController;

      default:
        return TextEditingController();
    }
  }

  String? _getValidatorFromLabel(String label, String? value) {
    switch (label) {
      case 'Title*':
        if (value != null && value.trim().isEmpty) {
          return 'Please enter a title';
        }

        return null;

      case "Password":
        return null;

      case "Capacity*":
        if (value != null && value.trim().isEmpty) {
          return 'Please enter number of players.';
        }

        if (value != null) {
          int? number = int.tryParse(value.trim());

          if (number == null) {
            return 'Please enter number of players.';
          }
        }

        return null;

      default:
        return null;
    }
  }

  void _onCreate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final authController = Get.find<AuthController>();
      _controller
          .createNewBoard(
        authController.user.value.username,
        _titleController.text.trim(),
        _passwordController.text.trim().isEmpty
            ? null
            : _passwordController.text.trim(),
        _controller.selectedGame.value.capacity > 0
            ? null
            : int.parse(_capacityController.text.trim()),
        _controller.selectedGame.value.title,
      )
          .then((value) {
        if (value) {
          Navigator.pop(context, true);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
