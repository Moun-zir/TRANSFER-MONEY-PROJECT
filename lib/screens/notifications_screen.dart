import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfermoneyproject/providers/transaction_provider.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          final transactions = transactionProvider.transactions;

          if (transactions.isEmpty) {
            return const Center(
              child: Text("Aucune transaction récente",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.now());

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: transaction.amount < 0 ? Colors.redAccent : Colors.green,
                    child: const Icon(Icons.monetization_on, color: Colors.white),
                  ),
                  title: Text(
                    "Vous avez envoyé ${transaction.amount.abs().toStringAsFixed(2)}€ à ${transaction.name}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("📅 $formattedDate"),
                  trailing: Icon(Icons.notifications, color: Colors.blueAccent),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
