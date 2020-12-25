import 'package:online_games/models/Message.dart';
import 'package:online_games/utils/storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Socket {
  static WebSocketChannel? _channel;
  static Stream<dynamic>? _channelStream;
  static const String BASIC_URL = "ws://localhost:8080";

  static _initChannel() {
    _channel = WebSocketChannel.connect(
        Uri.parse("$BASIC_URL?token=${Storage.getValue(Storage.TOKEN)}"));
  }

  static Stream<dynamic> getStream(Message message) {
    if (_channel == null) {
      _initChannel();
    }

    _channel!.sink.add(message.toString());

    if (_channelStream == null) {
      _channelStream = _channel!.stream.asBroadcastStream();
    }

    return _channelStream!;
  }
}
