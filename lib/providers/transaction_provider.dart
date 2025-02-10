import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionItem> _transactions = [];

  List<TransactionItem> get transactions => _transactions;

  void addTransaction({
    required String name,
    required double amount,
    required IconData icon,
    required TransactionType transactionType,  // Ajoutez le type de transaction
  }) {
    print("Ajout d'une transaction: $name, montant: $amount"); // DEBUG

    // Ajoute seulement la transaction si elle n'est pas déjà présente
    if (!_transactions.any((transaction) => transaction.name == name && transaction.amount == amount)) {
      _transactions.insert(
        0,
        TransactionItem(
          name: name,
          date: DateTime.now().toString(),
          amount: amount,
          icon: icon,
          transactionType: transactionType,  // Passez le type de transaction
        ),
      );
    }

    notifyListeners();
  }

  void deleteTransaction(String name) {
  _transactions.removeWhere((transaction) => transaction.name == name);
  notifyListeners();
  }
}


enum TransactionType { addMoney, transfer }

class TransactionItem {
  final String name;
  final String date;
  final double amount;
  final IconData icon;
  final TransactionType transactionType;  // Ajoutez ce champ

  TransactionItem({
    required this.name,
    required this.date,
    required this.amount,
    required this.icon,
    required this.transactionType,  // Passez le type de transaction
  });
}
