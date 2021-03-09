import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_games/utils/storage.dart';

class API {
  static const String BASIC_URL = "http://localhost:8080";
  static const String GET_ALL_GAMES = "$BASIC_URL/game/allGames";
  static const String LOGIN = "$BASIC_URL/auth/signin";
  static const String SIGNUP = "$BASIC_URL/auth/signup";
  static const String VALIDATE_TOKEN = "$BASIC_URL/auth/validateToken";
  static const String GET_NEW_TOKEN = "$BASIC_URL/auth/getNewToken";
  static const String GET_GAME = "$BASIC_URL/game/getGame";
  static const String CREATE_NEW_BOARD = "$BASIC_URL/game/createNewBoard";

  static Future<List<dynamic>> getAllGames() async {
    try {
      final response = await http.get(Uri.parse(GET_ALL_GAMES),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic?> getGameByTitle(String gameTitle) async {
    try {
      final response = await http.post(
        Uri.parse(GET_GAME),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"title": "$gameTitle"}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic?> createNewBoard(String creator, String title,
      String? password, int? capacity, String gameTitle) async {
    Map<String, dynamic> body = {
      "creator": creator,
      "title": title,
      "gameTitle": gameTitle,
    };

    if (password != null) {
      body.addAll({
        "password": password,
      });
    }

    if (capacity != null) {
      body.addAll({
        "capacity": capacity,
      });
    }

    try {
      final response = await http.post(
        Uri.parse(CREATE_NEW_BOARD),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Storage.getValue(Storage.TOKEN)}",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(LOGIN),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> signUp(
      String email, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(SIGNUP),
        headers: {"Content-Type": "application/json"},
        body: json.encode(
            {"email": email, "username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> validateToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse(VALIDATE_TOKEN),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getNewToken(String refresh) async {
    try {
      final response = await http.post(
        Uri.parse(GET_NEW_TOKEN),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"refreshToken": refresh}),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
