import 'package:flutter/material.dart';
import 'package:transfermoneyproject/models/user.dart'; // Exemple d'importation pour User

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<User> users = List.from(Users); // Assurez-vous que `Users` est bien défini.

  String errorMessage = ''; // Message d'erreur en cas de mauvaise connexion

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final user = users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => User(username: '', password: ''),
    );

    if (user.username.isNotEmpty) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        errorMessage = 'Identifiants incorrects';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Couleur de l'AppBar en teal
        title: const Text('Login', style: TextStyle(color: Colors.white)), // Couleur du titre
      ),
      body: Center(
        child: SizedBox(
          width: 500, // Taille du formulaire
          height: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white, // Fond blanc pour le formulaire
                      border: Border.all(
                        color: Colors.teal, // Bordure en teal
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Étendre la colonne
                      children: [
                        const Center(
                          child: Text(
                            "WELCOME BACK",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto sans serif",
                              color: Colors.teal, // Couleur du titre en teal
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Champ Username avec icône
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: Colors.teal, // Icône teal
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200], // Couleur de fond gris clair
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Champ Mot de passe avec icône
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.teal, // Icône teal
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Message d'erreur
                        if (errorMessage.isNotEmpty)
                          Center(
                            child: Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),

                        const SizedBox(height: 20), // Ajout d'un espacement

                        // Bouton de connexion
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Logique de connexion réussie...
                              Navigator.pushReplacementNamed(context, '/home'); // ✅ Remplace la page Login par Home
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Colors.teal, // Couleur du bouton en teal
                            ),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20), // Ajout d'un espacement

                        // Lien "Forget Password?"
                        const Center(
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: Colors.pinkAccent, // Changer la couleur en rose
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30), // Espacement avant le lien d'inscription

                        // Lien "Don't have an account? Sign up"
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Sign up",
                                    style: TextStyle(
                                      color: Colors.pinkAccent, // Changer la couleur en rose
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}