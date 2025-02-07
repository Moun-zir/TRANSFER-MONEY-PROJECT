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
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "\$${balanceProvider.balance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto sans serif",
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.addMoney);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, 
                        foregroundColor: Colors.black, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text("Add Money"),
                    ),

                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.transferMoney);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, 
                        foregroundColor: Colors.black, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text("Transfer"),
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
