import 'package:get/get.dart';
import 'package:online_games/models/User.dart';
import 'package:online_games/utils/api.dart';

class AuthController extends GetxController {
  Rx<User> user = User("", "", "", false).obs;

  @override
  void onInit() {
    API
        .login("dimitriscs081567@hotmail.com", "123456")
        .then((value) => user.value = User.fromMap(value));

    super.onInit();
  }
}
