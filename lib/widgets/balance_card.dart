import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../routes/routes.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required double balance});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceProvider>(
      builder: (context, balanceProvider, child) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          // ignore: deprecated_member_use
          color: const Color.fromARGB(255, 232, 235, 232), // Couleur de fond de la carte
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Solde affiché
                Text(
                  "\$${balanceProvider.balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto sans serif",
                    color: Colors.blueAccent, // Couleur du montant
                  ),
                ),
                const SizedBox(height: 30),

                // Row avec les deux boutons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bouton "Add Money"
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.addMoney);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.add, size: 18), // Icône pour Add Money
                      label: const Text("Add Money"),
                    ),

                    const SizedBox(width: 20),

                    // Bouton "Transfer"
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.transferMoney);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      icon: const Icon(Icons.send, size: 18), // Icône pour Transfer
                      label: const Text("Transfer"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
