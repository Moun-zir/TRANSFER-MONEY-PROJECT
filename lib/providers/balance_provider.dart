import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';

class BalanceProvider with ChangeNotifier {
  double _balance = 3200.75;
  final List<Map<String, dynamic>> _cards = [
    {
      "title": "Ecobank bank",
      "number": "**** **** **** 1234",
      "balance": 2500.00,
    },
    {
      "title": "Bank Atlantique",
      "number": "**** **** **** 5678",
      "balance": 700.75,
    },
  ];

  double get balance => _balance;
  List<Map<String, dynamic>> get cards => _cards;

  /// Ajoute de l'argent à une carte et met à jour le solde total
  void addMoney(double amount, int cardIndex, BuildContext context) {
    _cards[cardIndex]['balance'] += amount;
    _updateTotalBalance();

    // Ajouter la transaction "Ajout d'argent" dans l'historique
    Provider.of<TransactionProvider>(context, listen: false).addTransaction(
      name: "Ajout d'argent sur ${_cards[cardIndex]['title']}",
      amount: amount,
      icon: Icons.account_balance_wallet,
      transactionType: TransactionType.addMoney,  // Ajoutez le type de transaction
    );

    notifyListeners();
  }

  /// Transfert d'argent d'une carte (débit)
  void transferMoney(double amount, int cardIndex, BuildContext context) {
    if (_cards[cardIndex]['balance'] >= amount) {
      _cards[cardIndex]['balance'] -= amount;
      _updateTotalBalance();

      // Ajouter une transaction "Transfert d'argent"
      Provider.of<TransactionProvider>(context, listen: false).addTransaction(
        name: "Transfert depuis ${_cards[cardIndex]['title']}",
        amount: -amount, // Montant négatif car c'est un débit
        icon: Icons.send,
        transactionType: TransactionType.transfer,  // Ajoutez le type de transaction
      );

      notifyListeners();
    }
  }

  


  /// Met à jour le solde total en recalculant les soldes des cartes
  void _updateTotalBalance() {
    _balance = _cards.fold(0, (total, card) => total + card['balance']);
    notifyListeners();
  }
}
