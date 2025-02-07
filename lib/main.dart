import 'package:flutter/material.dart';
import 'package:transfermoneyproject/login_page.dart';
import 'package:transfermoneyproject/register_page.dart';
import 'screens/accueil_screen.dart'; // Assure-toi d'importer la bonne page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', //(Page d'entrée , la page principale)
      routes: {
        '/':(context) => IntroScreen(),//Page d'introduction
        '/register': (context) => RegisterPage(), //Page d'inscription
        '/login': (context) => LoginPage(), //Page de connexion
        // '/home':(context) => AccueilScreen()
      },
    );
  }
}
