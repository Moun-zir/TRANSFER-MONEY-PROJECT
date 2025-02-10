import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/credit_card.dart';
import '../providers/balance_provider.dart';
import '../providers/transaction_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mounzir Osseni", style: TextStyle(color: Colors.white, fontFamily: "Roboto sans serif"),),
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.qr_code, size: 28, color: Colors.white,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "BALANCE SOLDE",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto sans serif",
                  color: Colors.green
                  ),
              ),
            ),
            const SizedBox(height: 10),
            Consumer<BalanceProvider>(
              builder: (context, balanceProvider, child) {
                return BalanceCard(balance: balanceProvider.balance);
              },
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true, // Important to avoid unnecessary scroll
              physics: const NeverScrollableScrollPhysics(), // Prevent list from scrolling
              padding: const EdgeInsets.only(top: 10),
              itemCount: context.watch<BalanceProvider>().cards.length,
              itemBuilder: (context, index) {
                final card = context.watch<BalanceProvider>().cards[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CreditCard(
                    cardTitle: card['title'],
                    cardNumber: card['number'],
                    balance: card['balance'],
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1.5),
            const SizedBox(height: 5),
            const Text(
              "TRANSACTIONS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const TransactionList(),
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        final transactions = transactionProvider.transactions;

        if (transactions.isEmpty) {
          return const Center(
            child: Text(
              "Aucune transaction pour le moment.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true, // Important to avoid unnecessary scroll
          physics: const NeverScrollableScrollPhysics(), // Prevent list from scrolling
          itemCount: transactions.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            return Dismissible(
              key: Key(transaction.name.toString()), // Unique key for each transaction
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // Delete the transaction from the provider
                transactionProvider.deleteTransaction(transaction.name);
                
                // Show a snack bar notification
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Transaction ${transaction.name} supprimée.",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
              background: Container(
                color: Colors.redAccent,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(transaction.icon, color: Colors.black87),
                ),
                title: Text(
                  transaction.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(transaction.date, style: const TextStyle(color: Colors.grey)),
                trailing: Text(
                  "${transaction.amount < 0 ? '-' : '+'} \$${transaction.amount.abs().toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: transaction.amount < 0 ? Colors.red : Colors.green,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
