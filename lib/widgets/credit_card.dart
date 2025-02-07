import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final String cardTitle;
  final String cardNumber;
  final double balance;

  const CreditCard({
    super.key,
    required this.cardTitle,
    required this.cardNumber,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity, // Prend toute la largeur disponible
        margin: const EdgeInsets.symmetric(horizontal: 15), // Ajoute un peu d'espace à gauche/droite
        padding: const EdgeInsets.all(10), // Espacement interne plus grand
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardTitle, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(cardNumber, style: const TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 2)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("\$${balance.toStringAsFixed(2)}", 
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );

  }
}
