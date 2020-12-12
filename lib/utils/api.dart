import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:online_games/models/Game.dart';

class API {
  static const String BASIC_URL = "http://localhost:8080";
  static const String GET_ALL_GAMES = "$BASIC_URL/game/allGames";

  static Future<List<Game>> getAllGames() async {
    try {
      final response = await http
          .get(GET_ALL_GAMES, headers: {"Content-Type": "application/json"});
      final body = json.decode(response.body) as List<dynamic>;
      List<Game> result = body.map((game) => Game.fromMap(game)).toList();

      return result;
    } catch (e) {
      print(e.message);
      return null;
    }
  }
}