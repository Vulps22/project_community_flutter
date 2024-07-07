import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_community_flutter/models/server.dart';
import 'package:project_community_flutter/models/server_list_item.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:project_community_flutter/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'models/channel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with WindowListener {
  String _statusMessage = "Starting...";

  @override
  void initState() {
    super.initState();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(400, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await doStartup();
    });
  }

  Future<void> _loadData() async {
    _updateStatus("Loading your data...");

    // Fetch the server list and store it
    await _fetchAndStoreServerList();

    // Check if there is a last selected server and channel
    await _checkLastSelected();

    // Navigate to the main screen
    Navigator.pushReplacementNamed(context, '/main');
  }

  Future<void> _fetchAndStoreServerList() async {
    _updateStatus("Fetching your server list...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ServerListItem> servers = await getServers();
    // Store servers in StateManagerProvider
    Provider.of<StateManagerProvider>(context, listen: false).servers = servers;
  }

  Future<void> _checkLastSelected() async {
    _updateStatus("Returning to where you left off...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lastServerId = prefs.getString('last_server_id');
    var lastChannelId = prefs.getString('last_channel_id');

    if (lastServerId != null && lastChannelId != null) {
      var server =
          await Provider.of<StateManagerProvider>(context, listen: false)
              .selectAndLoadServer(lastServerId);
      if (server != null) {
        // Get the last channel used. If that channel has been deleted or the server is being loaded for the first time, get the first channel in the list
        Channel channel;
        try {
          channel = server.channels
              .firstWhere((channel) => channel.id == lastChannelId);
        } catch (e) {
          channel = server.channels.first;
        }
        Provider.of<StateManagerProvider>(context, listen: false)
            .selectChannel(channel);
      }
    }
  }

  Future<void> doStartup() async {
    _updateStatus("Checking you're logged in...");
    bool isLoggedIn = await _checkAuthToken();
    if (isLoggedIn) {
      await _loadData();
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<bool> _checkAuthToken() async {
    _updateStatus("Checking authentication...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  void _updateStatus(String message) {
    setState(() {
      _statusMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusMessage,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
