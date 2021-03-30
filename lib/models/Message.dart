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

  Message.getBoard(String creator, String? password) {
    _type = "getBoard";
    _params = (password != null ? [creator, password] : [creator])
        .map((param) => ":$param")
        .toList();
  }

  Message.joinBoard(String creator, int position, String? password) {
    _type = "joinBoard";
    _params =
        (password != null ? [creator, position, password] : [creator, position])
            .map((param) => ":$param")
            .toList();
  }

  Message.leaveBoard(String creator, String? password) {
    _type = "leaveBoard";
    _params = [creator].map((param) => ":$param").toList();
  }

  Message.kickPlayer(String player) {
    _type = "kickPlayer";
    _params = [player].map((param) => ":$param").toList();
  }

  Message.playerReady(String creator) {
    _type = "playerReady";
    _params = [creator].map((param) => ":$param").toList();
  }

  String get type => this._type;

  @override
  String toString() {
    return "$_type${_params.join()}";
  }
}
