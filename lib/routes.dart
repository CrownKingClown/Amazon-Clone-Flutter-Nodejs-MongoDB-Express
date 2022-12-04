import 'package:flutter/material.dart';
import './features/auth/screens/auth_screen.dart'; //AuthScreen
import './features/home/screens/home_screen.dart';
import 'common/widgets/bottom_bar.dart'; //HomeScreen

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const BottomBar());

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('La pagina non esiste'),
          ),
        ),
      );
  }
}
