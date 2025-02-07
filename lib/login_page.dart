import 'package:flutter/material.dart';

// Assurez-vous d'avoir défini la classe `User` quelque part dans votre code ou l'importer correctement
import 'package:transfermoneyproject/models/user.dart'; // Exemple d'importation pour User

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Liste des utilisateurs
  final List<User> users = List.from(Users); // Assurez-vous que `Users` est bien défini.

  String errorMessage = ''; // Message d'erreur en cas de mauvaise connexion

  // Fonction de connexion
  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    final user = users.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(email: '', password: ''),
    );

    if (user.email.isNotEmpty) {
      // Connexion réussie, rediriger vers la Todo List ou autre écran
      Navigator.pushNamed(context, '/home');
    } else {
      // Connexion échouée
      setState(() {
        errorMessage = 'Identifiants incorrects';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Pour enlever l'ombre de l'AppBar
      ),
      body: SizedBox(
        width: double.infinity,
        height: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
          child: Column(
            children: [
              // Colonne pour le formulaire
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 133, 93, 241),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre
                      const Center(
                        child: Text(
                          "WELCOME BACK",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto sans serif",
                            color: Color.fromARGB(255, 133, 93, 241),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Champ Email avec icône
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 133, 93, 241),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
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
                            color: Color.fromARGB(255, 133, 93, 241),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Message d'erreur
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),

                      // Bouton de connexion
                      Center(
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: const Color.fromARGB(255, 147, 113, 232),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Lien "Forget Password?"
                      const Center(
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

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
                                    color: Colors.blueAccent,
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
    );
  }
}
