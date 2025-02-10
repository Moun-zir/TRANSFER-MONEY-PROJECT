import 'package:flutter/material.dart';
import 'package:transfermoneyproject/login_page.dart';
import 'package:transfermoneyproject/main.dart';
import 'package:transfermoneyproject/register_page.dart';
import 'package:transfermoneyproject/screens/accueil_screen.dart';
import 'package:transfermoneyproject/screens/add_money_screen.dart';
import 'package:transfermoneyproject/screens/home_screen.dart';
import 'package:transfermoneyproject/screens/transfer_screen.dart';

class AppRoutes {

  static const String home = '/';
  static const String addMoney = '/add-money';
  static const String transferMoney = '/transfer-money';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case addMoney:
        return MaterialPageRoute(builder: (_) => const AddMoneyScreen());
      case transferMoney:
        return MaterialPageRoute(builder: (_) => const TransferScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route inconnue : ${settings.name}'),
            ),
          ),
        );
    }
  }
}
