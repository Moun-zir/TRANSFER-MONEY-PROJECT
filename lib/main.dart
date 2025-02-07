import 'package:flutter/material.dart';
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
    );
  }
}
