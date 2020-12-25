import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_games/controllers/auth_controller.dart';
import 'package:online_games/utils/constants.dart';
import 'package:online_games/widgets/main_app_bar.dart';
import 'package:online_games/widgets/unauthorized_widget.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget? child;
  final Widget? floatingButton;
  final String? appbarTitle;
  final bool? withAuthentication;

  ScreenWrapper({
    @required this.child,
    this.floatingButton,
    @required this.appbarTitle,
    this.withAuthentication,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(Constants.APP_BAR_HEIGHT),
        child: MainAppBar(appbarTitle: appbarTitle),
      ),
      floatingActionButton: GetX<AuthController>(
          init: AuthController(),
          builder: (controller) {
            if (!controller.user.value.isLoggedIn() || floatingButton == null) {
              return Container();
            }

            return floatingButton;
          }),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: Constants.MAX_WIDTH),
          child: GetX<AuthController>(
              init: AuthController(),
              builder: (controller) {
                if (!controller.user.value.isLoggedIn()) {
                  if (withAuthentication == null || !withAuthentication!) {
                    return child;
                  }

                  return UnauthorizedWidget();
                }

                return child;
              }),
        ),
      ),
    );
  }
}
