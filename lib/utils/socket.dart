import 'package:online_games/utils/storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Socket {
  static WebSocketChannel? _channel;
  static const String BASIC_URL = "ws://localhost:8080";

  static _initChannel() {
    _channel = WebSocketChannel.connect(
        Uri.parse("$BASIC_URL?token=${Storage.getValue(Storage.TOKEN)}"));
  }

  static WebSocketChannel getChannel(String gameTitle) {
    if (_channel == null) {
      _initChannel();
    }

    getAllBoards(gameTitle);

    return _channel!;
  }

  static getAllBoards(String gameTitle) {
    if (_channel != null) {
      _channel!.sink.add("boards:$gameTitle");
    }
  }
}
