import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String TOKEN = "token";
  static const String REFRESH_TOKEN = "refreshToken";
  static const String BOARD_PASS = "boardPassword";

  static Future<SharedPreferences> get storage =>
      SharedPreferences.getInstance();

  static Future<void> saveValue(String key, String value) async {
    (await storage).setString(key, value);
  }

  static Future<String?> getValue(String key) async {
    return (await storage).getString(key);
  }
}
