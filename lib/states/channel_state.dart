import 'package:flutter/material.dart';
import '../models/message.dart';

@Deprecated("Use StateManagerProvider instead")
class ChannelState extends ChangeNotifier {
  String _selectedChannelId = '';
  String _serverId = '';
  List<Message> _messages = [];

  String get selectedChannelId => _selectedChannelId;
  String get serverId => _serverId;
  List<Message> get messages => _messages;
@Deprecated("Use StateManagerProvider instead")
  void setServerId(String serverId) {
    _serverId = serverId;
    notifyListeners();
  }

@Deprecated("Use StateManagerProvider instead")
  void selectChannel(String channelId) async {
    throw new Exception("REDUNDANT FUNCTION STILL IN USE");
  }
}
