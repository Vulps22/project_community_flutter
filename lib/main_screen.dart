import 'package:flutter/material.dart';
import 'package:project_community_flutter/widgets/chat.dart';
import 'package:project_community_flutter/widgets/sidebar.dart';
import 'package:window_size/window_size.dart';
import 'package:window_manager/window_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.hide();
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
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: <Widget>[
          Sidebar(serverId: '6681d8b804a5fe4b21e2cabe',),
          Expanded(
            child: ChatArea(),
          ),
        ],
      ),
    );
  }
}