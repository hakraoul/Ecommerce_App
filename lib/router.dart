import 'package:ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const AuthScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist"),
          ),
        ),
      );
  }
}
