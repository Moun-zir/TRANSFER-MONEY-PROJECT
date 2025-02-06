import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/credit_card.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mounzir Osseni"),
        backgroundColor: const Color.fromARGB(255, 247, 246, 246),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.window, size: 28),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Balance",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // Utilise Consumer pour écouter les changements de balance
            Consumer<BalanceProvider>(
              builder: (context, balanceProvider, child) {
                return BalanceCard(balance: balanceProvider.balance);
              },
            ),
            const SizedBox(height: 20),
            const CreditCard(
              cardTitle: "Primary Card",
              cardNumber: "**** **** **** 1234",
              balance: 2500.00,
            ),
            const SizedBox(height: 15),
            const CreditCard(
              cardTitle: "Secondary Card",
              cardNumber: "**** **** **** 5678",
              balance: 700.75,
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1.2), // Barre de séparation
            const SizedBox(height: 10),
            const Text(
              "Transactions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: TransactionList()),
          ],
        ),
      ),
    );
  }
}


// 📋 Liste des transactions
class TransactionList extends StatelessWidget {
  final List<TransactionItem> transactions = [
    TransactionItem(name: "Starbucks", date: "Jan 25, 10:30 AM", amount: -5.75, icon: Icons.local_cafe),
    TransactionItem(name: "Amazon Purchase", date: "Jan 24, 08:45 PM", amount: -150.00, icon: Icons.shopping_cart),
    TransactionItem(name: "Salary", date: "Jan 23, 06:00 AM", amount: 3200.00, icon: Icons.account_balance_wallet),
    TransactionItem(name: "Netflix", date: "Jan 22, 09:00 PM", amount: -13.99, icon: Icons.movie),
  ];

  TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(transaction.icon, color: Colors.black87),
          ),
          title: Text(transaction.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(transaction.date, style: const TextStyle(color: Colors.grey)),
          trailing: Text(
            "\$${transaction.amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: transaction.amount < 0 ? Colors.red : Colors.green,
            ),
          ),
        );
      },
    );
  }
}

// 📝 Modèle de Transaction
class TransactionItem {
  final String name;
  final String date;
  final double amount;
  final IconData icon;

  TransactionItem({required this.name, required this.date, required this.amount, required this.icon});
}
