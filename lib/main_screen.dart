import 'package:flutter/material.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:project_community_flutter/states/channel_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'widgets/channel_bar.dart';
import 'widgets/chat_area.dart';
import 'widgets/server_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 1080),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.maximize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const ServerBar(),
          const ChannelBar(),
          Expanded(
            child: Consumer<ChannelState>(
              builder: (context, channelState, child) {
                return ChatArea(initialMessages: channelState.messages);
              },
            ),
          ),
        ],
      ),
    );
  }
}
