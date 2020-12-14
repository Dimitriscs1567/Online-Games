import 'package:get/get.dart';
import 'package:online_games/models/User.dart';
import 'package:online_games/utils/api.dart';

class AuthController extends GetxController {
  Rx<User> user = User("", "", "", false).obs;

  @override
  void onInit() {
    API
        .login("dimis", "123456")
        .then((value) => user.value = User.fromMap(value));

    super.onInit();
  }
}
