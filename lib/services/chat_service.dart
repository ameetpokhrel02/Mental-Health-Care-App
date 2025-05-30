import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ChatService {
  late WebSocketChannel channel;
  Function(Map<String, dynamic>)? onMessageReceived;
  final String token;

  ChatService(this.token) {
    _connectWebSocket();
  }

  void _connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:5000/ws?token=$token'),
    );

    channel.stream.listen(
      (message) {
        final data = json.decode(message);
        if (onMessageReceived != null) {
          onMessageReceived!(data);
        }
      },
      onError: (error) {
        print('WebSocket Error: $error');
        _reconnect();
      },
      onDone: () {
        print('WebSocket Connection Closed');
        _reconnect();
      },
    );
  }

  void _reconnect() {
    Future.delayed(Duration(seconds: 5), () {
      _connectWebSocket();
    });
  }

  void sendMessage(String recipientId, String content) {
    channel.sink.add(json.encode({
      'type': 'message',
      'recipientId': recipientId,
      'content': content,
    }));
  }

  void sendTypingStatus(String recipientId) {
    channel.sink.add(json.encode({
      'type': 'typing',
      'recipientId': recipientId,
    }));
  }

  void dispose() {
    channel.sink.close();
  }
}