import 'package:ecommerce_app/common/widgets/bottom_bar.dart';
import 'package:ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const HomeScreen(),
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
