import 'package:get_storage/get_storage.dart';

class Storage {
  static const String TOKEN = "token";
  static const String REFRESH_TOKEN = "refreshToken";

  static void saveValue(String key, String value) {
    GetStorage().write(key, value);
  }

  static String getValue(String key) {
    return GetStorage().read(key);
  }
}
