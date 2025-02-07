import 'package:flutter/material.dart';
import 'package:transfermoneyproject/models/user.dart'; // Exemple d'importation pour User
import 'login_page.dart'; // Assurez-vous que la page de connexion est correctement importée

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String errorMessage = '';

  void _register() {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Les mots de passe ne correspondent pas";
      });
      return;
    }

    // Logique d'enregistrement de l'utilisateur
    // User newUser = User(username: username, email: email, password: password);
    // SaveUser(newUser);

    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Couleur de l'AppBar en teal
        title: const Text('Register', style: TextStyle(color: Colors.white)), // Couleur du titre
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          height: 980,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 1, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 45, 20, 45),
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 50),
                    decoration: BoxDecoration(
                      color: Colors.white, // Fond blanc pour le formulaire
                      border: Border.all(
                        color: Colors.teal, // Bordure en teal
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal, // Couleur du titre en teal
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Create your account",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Champ Username
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person, color: Colors.teal), // Icône teal
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200], // Couleur de fond gris clair
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Champ Email
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email, color: Colors.teal), // Icône teal
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Champ Password
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock, color: Colors.teal), // Icône teal
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Champ Confirm Password
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.teal), // Icône teal
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Message d'erreur
                        if (errorMessage.isNotEmpty)
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),

                        // Bouton Sign Up
                        Center(
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Colors.orange, // Couleur du bouton en orange
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Texte "or"
                        const Center(
                          child: Text(
                            "or",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Bouton Sign Up with Google
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Logique pour connexion Google (à implémenter)
                            },
                            icon: const Icon(Icons.g_translate, color: Colors.teal), // Icône teal
                            label: const Text(
                              'Sign Up with Google',
                              style: TextStyle(fontSize: 16, color: Colors.teal), // Texte teal
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color: Colors.teal, // Bordure teal
                                  width: 1,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 246, 246, 246),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Lien "You have already an account? Sign in"
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: "You have already an account? ",
                                style: TextStyle(fontSize: 14, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Sign in",
                                    style: TextStyle(
                                      color: Colors.orange, // Couleur du lien en orange
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