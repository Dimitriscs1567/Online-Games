import 'package:flutter/material.dart';
import 'package:online_games/widgets/dialogs/login_signup_dialog.dart';

class UnauthorizedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You need to login to access this page!",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 20.0,
            )),
          ),
          child: Text(
            "Login / Sign up",
            style: TextStyle(fontSize: 19.0),
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => LoginSignUpDialog(),
          ),
        )
      ],
    );
  }
}
