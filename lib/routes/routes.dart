import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/add_money_screen.dart';
import '../screens/transfer_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String addMoney = '/add-money';
  static const String transferMoney = '/transfer-money';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case addMoney:
        return MaterialPageRoute(builder: (_) => const AddMoneyScreen());
      case transferMoney:
        return MaterialPageRoute(builder: (_) => const TransferScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
