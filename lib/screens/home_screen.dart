import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan avec l'image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/anim1.jpg'),  // Ton image ici
                fit: BoxFit.cover,  // L'image s'ajuste à la taille de l'écran
              ),
            ),
          ),
          // Le texte SKIP en haut à droite
          Positioned(
            top: 20,  // Position verticale du texte
            right: 20,  // Position horizontale du texte
            child: GestureDetector(
              onTap: () {
                // Action lors du clic sur "SKIP" (ex: navigation vers une autre page)
                print("SKIP tapped");
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.5),  // Fond sombre derrière le texte
                  // padding: EdgeInsets.all(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
