import 'package:project_community_flutter/models/channel.dart';
import 'package:project_community_flutter/models/server.dart';
import 'package:project_community_flutter/models/user.dart';

@Deprecated("Use StateManagerProvider instead")
class StateManager {
  static final StateManager _instance = StateManager._internal();
  User? _currentUser;
  Server? _selectedServer;
  Channel? _selectedChannel;

  factory StateManager() {
    return _instance;
  }

  StateManager._internal();

  User? get currentUser => _currentUser;
  Server? get selectedServer => _selectedServer;
  Channel? get selectedChannel => _selectedChannel;

  set currentUser(User? user) {
    _currentUser = user;
  }

  set selectedServer(Server? server) {
    _selectedServer = server;
  }

  set selectedChannel(Channel? channel) {
    _selectedChannel = channel;
  }
}
