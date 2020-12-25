class Message {
  late String _type;
  late List<String> _params;

  Message(this._type, List<String> params) {
    _params = params.map((param) => ":$param").toList();
  }

  Message.allBoards(String gameTitle) {
    _type = "boards";
    _params = [gameTitle].map((param) => ":$param").toList();
  }

  Message.getBoard(String creator) {
    _type = "getBoard";
    _params = [creator].map((param) => ":$param").toList();
  }

  String get type => this._type;

  @override
  String toString() {
    return "$_type${_params.join()}";
  }
}
