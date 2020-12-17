class Game {
  late String _title;
  late String _image;

  Game(this._title, this._image);

  Game.fromMap(dynamic map) {
    this._title = map["title"];
    this._image = map["image"];
  }

  String get title => this._title;
  String get image => this._image;
}
