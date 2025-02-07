import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionItem> _transactions = [];

  List<TransactionItem> get transactions => _transactions;

  void addTransaction({required String name, required double amount, required IconData icon}) {
  print("Ajout d'une transaction: $name, montant: $amount"); // DEBUG

  _transactions.insert(0, TransactionItem(
    name: name,
    date: DateTime.now().toString(),
    amount: amount,
    icon: icon,
  ));

  notifyListeners();
}


}

class TransactionItem {
  final String name;
  final String date;
  final double amount;
  final IconData icon;

  TransactionItem({required this.name, required this.date, required this.amount, required this.icon});
}