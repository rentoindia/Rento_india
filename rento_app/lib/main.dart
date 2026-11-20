import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ⬅️ ADDED
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ⬅️ ADDED — required by ProviderScope below

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'core/bootstrap.dart';
import 'core/session.dart';
import 'screens/home_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // restores the login, connects the realtime channel and loads the user's data
  await AppBootstrap.init();
  final clearData = Session.instance.onLoggedOut;
  Session.instance.onLoggedOut = () {
    clearData?.call();
    rootNavigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (route) => false,
    );
  };

  runApp(const ProviderScope(child: RentoIndiaApp()));
}

class RentoIndiaApp extends StatelessWidget {
  const RentoIndiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      title: 'Rento India',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: Session.instance.isLoggedIn
          ? const HomeScreen()
          : const SplashScreen(),
    );
  }
}
