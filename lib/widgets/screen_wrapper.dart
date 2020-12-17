import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/widgets/dialogs/login_dialog.dart';
import 'package:online_games/widgets/unauthorized_widget.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget? child;
  final Widget? floatingButton;
  final String? appbarTitle;
  final bool? withAuthentication;

  ScreenWrapper({
    @required this.child,
    @required this.floatingButton,
    @required this.appbarTitle,
    @required this.withAuthentication,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(appbarTitle ?? ""),
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
          offstage:
              floatingButton == null || controller.user.value.username.isEmpty,
          child: floatingButton != null ? floatingButton : Container(),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            child: withAuthentication != null &&
                    withAuthentication! &&
                    controller.user.value.username.isEmpty
                ? UnauthorizedWidget()
                : child,
          ),
        ),
      ),
    );
  }

  void openDialog() {
    showDialog(context: Get.context, builder: (context) => LoginDialog());
  }
}
