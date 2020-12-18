import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';

import 'dialogs/login_signup_dialog.dart';

class MainAppBar extends StatelessWidget {
  late final String? appbarTitle;

  MainAppBar({@required this.appbarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appbarTitle ?? ""),
      centerTitle: true,
      actions: [
        GetX<AuthController>(
            init: AuthController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: controller.user.value.isLoggedIn()
                    ? _getIconButton()
                    : _getLoginButton(),
              );
            })
      ],
    );
  }

  Widget _getLoginButton() {
    return OutlineButton(
      borderSide: BorderSide.none,
      child: Text(
        "Login\nSign up",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onPressed: _openDialog,
    );
  }

  Widget _getIconButton() {
    return IconButton(
      icon: Icon(Icons.person),
      onPressed: () => {},
    );
  }

  void _openDialog() {
    showDialog(context: Get.context, builder: (context) => LoginSignUpDialog());
  }
}
