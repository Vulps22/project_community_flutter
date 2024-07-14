// socket_manager.dart
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class EventManagerProvider with ChangeNotifier {
  late IO.Socket socket;

  EventManagerProvider() {
    socket = IO.io('http://localhost:3000', IO.OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .build());
    socket.connect();
    _setupEvents();
  }

  void _setupEvents() {
    socket.on('connect', (_) {
      print('Socket connected');
      notifyListeners();
    });
    socket.on('disconnect', (_) {
      print('Socket disconnected');
      notifyListeners();
    });
    socket.on('error', (data) {
      print('Socket error: $data');
      notifyListeners();
    });
  }

  void joinServer(String serverId) {
    socket.emit('join', serverId);
  }

  void sendMessage(String serverId, String message) {
    socket.emit('message', {'serverId': serverId, 'message': message});
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
