import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/add_money_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String addMoney = '/add-money';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case addMoney:
        return MaterialPageRoute(builder: (_) => const AddMoneyScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
