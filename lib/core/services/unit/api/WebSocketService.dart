import 'package:web_socket_channel/web_socket_channel.dart';
import 'config/Config.dart';
import 'dart:io';

class WebSocketService {
  WebSocketChannel? channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void _setUpHttpOverrides() {
    HttpOverrides.global = MyHttpOverrides();
  }

  Future<bool> wsConnect(Function(String) onMessageReceived) async {
    _setUpHttpOverrides();

    try {
      final url = Uri.parse('${Config.websocketAddress}');
      print("Connecting to WebSocket: $url");
      channel = WebSocketChannel.connect(url);
      channel!.stream.listen(
            (message) {
          onMessageReceived(message);
        },
        onError: (error) {
          print("WebSocket connection error: $error");
          _isConnected = false;
          channel?.sink.close();
        },
        onDone: () {
          print("WebSocket connection closed.");
          _isConnected = false;
        },
      );

      _isConnected = true;
      return true;
    } catch (e) {
      print("Failed to connect: $e");
      _isConnected = false;
      return false;
    }
  }

  void sendMessage(String message) {
    if (_isConnected && channel != null) {
      channel!.sink.add(message);
    } else {
      print('Cannot send message: WebSocket is not connected.');
    }
  }

  void closeConnection() {
    channel?.sink.close();
    _isConnected = false;
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
