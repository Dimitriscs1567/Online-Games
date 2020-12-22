import 'package:get/get.dart';
import 'package:online_games/models/User.dart';
import 'package:online_games/utils/api.dart';
import 'package:online_games/utils/storage.dart';

class AuthController extends GetxController {
  Rx<User> user = User("", false).obs;

  @override
  void onInit() {
    getLoggedUser();

    super.onInit();
  }

  void getLoggedUser() async {
    bool haveUser = await _validateToken();

    if (!haveUser && await _getNewTokens()) {
      await _validateToken();
    }
  }

  Future<bool> _validateToken() async {
    String? token = Storage.getValue(Storage.TOKEN);
    if (token != null) {
      var validationResult = await API.validateToken(token);
      if (validationResult != null) {
        user.value = User.fromMap(validationResult);

        return true;
      }
    }

    return false;
  }

  Future<bool> _getNewTokens() async {
    String? refreshToken = Storage.getValue(Storage.REFRESH_TOKEN);
    if (refreshToken != null) {
      var refreshResult = await API.getNewToken(refreshToken);
      if (refreshResult != null) {
        Storage.saveValue(Storage.TOKEN, refreshResult["token"]);
        Storage.saveValue(Storage.REFRESH_TOKEN, refreshResult["refreshToken"]);

        return true;
      }
    }

    return false;
  }

  Future<bool> login(String email, String password) async {
    var response = await API.login(email, password);
    if (response != null) {
      Storage.saveValue(Storage.TOKEN, response["token"]);
      Storage.saveValue(Storage.REFRESH_TOKEN, response["refreshToken"]);
      user.value = User.fromMap(response);

      return true;
    }

    return false;
  }

  Future<bool> signUp(String email, String username, String password) async {
    var response = await API.signUp(email, username, password);
    if (response != null) {
      Storage.saveValue(Storage.TOKEN, response["token"]);
      Storage.saveValue(Storage.REFRESH_TOKEN, response["refreshToken"]);
      user.value = User.fromMap(response);

      return true;
    }

    return false;
  }
}
