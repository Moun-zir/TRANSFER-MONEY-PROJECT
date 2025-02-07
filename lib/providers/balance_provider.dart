import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';

class BalanceProvider with ChangeNotifier {
  double _balance = 3200.75;
  final List<Map<String, dynamic>> _cards = [
    {
      "title": "Primary Card",
      "number": "**** **** **** 1234",
      "balance": 2500.00,
    },
    {
      "title": "Secondary Card",
      "number": "**** **** **** 5678",
      "balance": 700.75,
    },
  ];

  double get balance => _balance;
  List<Map<String, dynamic>> get cards => _cards;

  void addMoney(double amount, int cardIndex, BuildContext context) {
    _cards[cardIndex]['balance'] += amount;
    updateBalance(amount);

    // Ajout d'une transaction "Ajout d'argent" dans l'historique
    Provider.of<TransactionProvider>(context, listen: false).addTransaction(
      name: "Ajout d'argent dans ${_cards[cardIndex]['title']}",
      amount: amount,
      icon: Icons.account_balance_wallet,
    );

    notifyListeners();
  }

  void transferMoney(double amount, int cardIndex) {
    if (_cards[cardIndex]['balance'] >= amount) {
      _cards[cardIndex]['balance'] -= amount;
      updateBalance(-amount);
      notifyListeners();
    }
  }

  void updateBalance(double amount) {
    _balance += amount;
    notifyListeners();
  }
}
