import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/widgets/dialogs/login_dialog.dart';

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
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(appbarTitle),
          centerTitle: true,
          actions: [
            controller.user.value.username.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: OutlineButton(
                      borderSide: BorderSide.none,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: openDialog,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () => {},
                    ),
                  ),
          ],
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
      ),
    );
  }

  void openDialog() {
    showDialog(context: Get.context, builder: (context) => LoginDialog())
        .then((value) => null);
  }
}
