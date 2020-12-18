import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_games/models/Game.dart';

class API {
  static const String BASIC_URL = "http://localhost:8080";
  static const String GET_ALL_GAMES = "$BASIC_URL/game/allGames";
  static const String LOGIN = "$BASIC_URL/auth/signin";
  static const String SIGNUP = "$BASIC_URL/auth/signup";
  static const String VALIDATE_TOKEN = "$BASIC_URL/auth/validateToken";
  static const String GET_NEW_TOKEN = "$BASIC_URL/auth/getNewToken";

  static Future<List<Game>> getAllGames() async {
    try {
      final response = await http
          .get(GET_ALL_GAMES, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List<dynamic>;
        List<Game> result = body.map((game) => Game.fromMap(game)).toList();
        return result;
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await http.post(
        LOGIN,
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
        SIGNUP,
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
        VALIDATE_TOKEN,
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
        GET_NEW_TOKEN,
        headers: {"Content-Type": "application/json"},
        body: {"refreshToken": refresh},
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
