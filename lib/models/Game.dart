import 'package:online_games/utils/api.dart';

class Game {
  late String _title;
  late String _image;
  late int _capacity;

  Game(this._title, this._image, this._capacity);

  Game.fromMap(dynamic map) {
    this._title = map["title"];
    this._image = API.BASIC_URL + "/" + map["image"];
    this._capacity = map["capacity"] ?? 0;
  }

  String get title => this._title;
  String get image => this._image;
  int get capacity => this._capacity;
}
