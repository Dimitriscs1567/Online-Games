import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class CRouter {
  static void push(BuildContext context, String url) {
    VRouterData.of(context).push(url);
  }

  static void replace(BuildContext context, String url) {
    VRouterData.of(context).pushReplacement(url);
  }

  static void pop(BuildContext context) {
    VRouterData.of(context).pop();
  }
}
