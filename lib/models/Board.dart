class Board {
  late String _title;
  late String _password;
  late String _creator;
  late int _capacity;
  late String _gameTitle;
  late String _created;
  late bool _started;
  late List<String> _otherPlayers;

  Board.empty() {
    this._title = "";
    this._password = "";
    this._creator = "";
    this._capacity = 0;
    this._gameTitle = "";
    this._created = "";
    this._started = false;
    this._otherPlayers = [];
  }

  Board.fromMap(dynamic map) {
    this._title = map["title"];
    this._password = map["password"] ?? "";
    this._creator = map["creator"];
    this._capacity = map["capacity"] as int;
    this._gameTitle = map["game"]["title"];
    this._created = _getCreatedMessage(map["createdAt"]);
    this._started = map["started"] as bool;
    this._otherPlayers = (map["otherPlayers"] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
  }

  String get title => this._title;
  String get password => this._password;
  String get creator => this._creator;
  String get created => this._created;
  String get gameTitle => this._gameTitle;
  int get capacity => this._capacity;
  bool get started => this._started;
  List<String> get otherPlayers => this._otherPlayers;

  String _getCreatedMessage(String date) {
    var parsedDate = DateTime.parse(date);

    return "Created " +
        DateTime.now().difference(parsedDate).inMinutes.toString() +
        " minutes ago";
  }

  bool isFull() {
    return _otherPlayers.length + 1 == _capacity;
  }

  String getPlayersText() {
    return "Players: ${_otherPlayers.length + 1} out of $_capacity";
  }
}
