import 'package:flutter/material.dart';
import 'package:project_community_flutter/models/channel.dart';
import 'package:project_community_flutter/models/message.dart';
import 'package:project_community_flutter/models/server.dart';
import 'package:project_community_flutter/models/server_list_item.dart';
import 'package:project_community_flutter/models/user.dart';
import 'package:project_community_flutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StateManagerProvider extends ChangeNotifier {
  User? _currentUser;
  Server? _selectedServer;
  Channel? _selectedChannel;
  List<Message> _messages = List.empty(growable: true);
  List<ServerListItem> _servers = List.empty(growable: true);

  User? get currentUser => _currentUser;
  Server? get selectedServer => _selectedServer;
  Channel? get selectedChannel => _selectedChannel;
  List<Message> get messages => _messages;
  List<ServerListItem> get servers => _servers;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  set selectedServer(Server? server) {
    _selectedServer = server;
    _saveLastSelected(true);
    notifyListeners();
  }

  set selectedChannel(Channel? channel) {
    _selectedChannel = channel;
    _saveLastSelected(false);
    notifyListeners();
  }

  set messages(List<Message> messages) {
    _messages = messages;
    notifyListeners();
  }

  set servers(List<ServerListItem> servers) {
    _servers = servers;
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void addServer(ServerListItem server) {
    _servers.add(server);
    notifyListeners();
  }

  Future<Server?> selectAndLoadServer(String id) async {
    try {
      Server server = await getServer(id);
      selectedServer = server;

      //select the last viewed channel for this server, or the first channel in the list
      _messages.clear(); //ensure there are no messages from previous server
       Channel channel = server.channels.first;

       SharedPreferences prefs = await SharedPreferences.getInstance();
       var lastChannelId = prefs.getString('last_channel_id');
       if(lastChannelId != null) {
        channel = server.channels.firstWhere((candidate) => candidate.id == lastChannelId);
       }

      selectChannel(channel);

      return server;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> selectChannel(Channel channel) async {
    _selectedChannel = channel;
    _messages = await getMessages(_selectedServer!.id, _selectedChannel!.id);
    notifyListeners();
  }

  Future<void> _saveLastSelected(bool saveServer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("saving selections");
    if (_selectedServer != null && saveServer) {
      prefs.setString('last_server_id', _selectedServer!.id);
    }
    if (_selectedChannel != null && !saveServer) {
      prefs.setString('last_channel_id', _selectedChannel!.id);
    }
  }
}
