import 'package:flutter/material.dart';
import './features/auth/screens/auth_screen.dart'; //AuthScreen

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const AuthScreen());
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
