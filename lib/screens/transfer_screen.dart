import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../providers/transaction_provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  double amount = 0;
  String selectedUser = "";
  int? selectedCardIndex; // Indice de la carte sélectionnée

  final List<Map<String, String>> users = [
    {"name": "Alice", "avatar": "assets/images/user1.jpg"},
    {"name": "John", "avatar": "assets/images/user5.jpg"},
    {"name": "Christiane", "avatar": "assets/images/user2.jpg"},
    {"name": "Franck", "avatar": "assets/images/user6.jpg"},
    {"name": "Marc", "avatar": "assets/images/user3.jpg"},
    {"name": "Charlie", "avatar": "assets/images/user7.jpg"},
  ];

  final List<double> quickAmounts = [10, 20, 50, 100, 200];

  void _updateAmount(double value) {
    setState(() {
      amount = value;
    });
  }

  void _sendMoney(BuildContext context) {
  final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
  final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);

  if (selectedUser.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sélectionnez un utilisateur")));
    return;
  }

  if (selectedCardIndex == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sélectionnez une carte bancaire")));
    return;
  }

  double cardBalance = balanceProvider.cards[selectedCardIndex!]['balance'];

  if (amount > cardBalance) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Solde insuffisant sur la carte")));
    return;
  }

  // Déduire le montant du solde de la carte et du solde global
  balanceProvider.transferMoney(amount, selectedCardIndex!, context);

  // Ajouter la transaction "Transfert depuis" seulement, pas celle "Transfert à"
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Vous avez envoyé \$${amount.toStringAsFixed(2)} à $selectedUser"),
      backgroundColor: Colors.green,
      ),
  );

  // Réinitialiser les valeurs
  setState(() {
    amount = 0;
    selectedUser = "";
    selectedCardIndex = null;
  });
}


  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Transfert d'argent")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sélectionner un destinataire", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: users.map((user) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUser = user["name"]!;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(user["avatar"]!),
                            backgroundColor: selectedUser == user["name"] ? Colors.blue : Colors.grey[300],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user["name"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedUser == user["name"] ? Colors.blue : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Sélectionner une carte bancaire", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<int>(
              value: selectedCardIndex,
              hint: const Text("Choisir une carte"),
              onChanged: (int? newValue) {
                setState(() {
                  selectedCardIndex = newValue;
                });
              },
              items: balanceProvider.cards.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> card = entry.value;
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text("${card['title']} - ${card['number']} (\$${card['balance'].toStringAsFixed(2)})"),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text("Montant à envoyer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Center(
              child: Text("\$${amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: quickAmounts.map((amt) {
                return ElevatedButton(
                  onPressed: () => _updateAmount(amt),
                  child: Text("\$$amt"),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Pavé numérique
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: List.generate(12, (index) {
                String text = index < 9 ? "${index + 1}" : index == 9 ? "C" : index == 10 ? "0" : "←";
                return InkWell(
                  onTap: () {
                    if (text == "C") {
                      _updateAmount(0);
                    } else if (text == "←") {
                      _updateAmount((amount / 10).floorToDouble());
                    } else {
                      _updateAmount(amount * 10 + double.parse(text));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text(text, style: const TextStyle(fontSize: 24))),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _sendMoney(context),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                child: const Text("Envoyer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
