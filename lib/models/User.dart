class User {
  String _token;
  String _refreshToken;
  String _username;
  bool _emailConfirmed;

  User(this._token, this._refreshToken, this._username, this._emailConfirmed);

  User.fromMap(dynamic map) {
    this._token = map["token"];
    this._refreshToken = map["refreshToken"];
    this._username = map["username"];
    this._emailConfirmed = map["emailConfirmed"];
  }

  String get token => this._token;
  String get refreshToken => this._refreshToken;
  String get username => this._username;
  bool get emailConfirmed => this._emailConfirmed;
}
