import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier {
  double _balance = 100.0; // Solde initial

  double get balance => _balance;

  void addMoney(double amount) {
    _balance += amount;
    notifyListeners(); // Met à jour l'UI
  }
}
