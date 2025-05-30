import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? socket;

  static void initSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.on('connect', (_) {
      print('Connected to socket server');
    });

    socket!.on('disconnect', (_) {
      print('Disconnected from socket server');
    });
  }

  static void sendMessage(String message, int receiverId) {
    socket!.emit('message', {
      'message': message,
      'receiverId': receiverId,
    });
  }

  static void listenForMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket!.on('message', (data) => onMessageReceived(data));
  }
}