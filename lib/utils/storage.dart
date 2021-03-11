import 'package:get_storage/get_storage.dart';

class Storage {
  static const String TOKEN = "token";
  static const String REFRESH_TOKEN = "refreshToken";
  static const String BOARD_PASS = "boardPassword";

  static void saveValue(String key, String value) {
    final box = GetStorage();
    box.write(key, value);
  }

  static String? getValue(String key) {
    final box = GetStorage();
    return box.read(key);
  }
}
