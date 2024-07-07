import 'package:flutter/material.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:project_community_flutter/register_screen.dart';
import 'package:project_community_flutter/states/channel_state.dart';
import 'package:project_community_flutter/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChannelState()),
        ChangeNotifierProvider(create: (_) => StateManagerProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Splash Screen Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainScreen(),
        },
      ),
    );
  }
}
