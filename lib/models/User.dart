class User {
  late String _username;
  late bool _emailConfirmed;

  User(this._username, this._emailConfirmed);

  User.fromMap(dynamic map) {
    this._username = map["username"];
    this._emailConfirmed = map["emailConfirmed"];
  }

  String get username => this._username;
  bool get emailConfirmed => this._emailConfirmed;

  bool isLoggedIn() {
    return this._username.isNotEmpty;
  }
}
