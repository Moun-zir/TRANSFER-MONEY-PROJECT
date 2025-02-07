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

  final List<Map<String, String>> users = [
    {"name": "Alice", "avatar": "assets/images/imgpsh_fullsize_anim.jpg"},
    {"name": "Bob", "avatar": "assets/images/imgpsh_fullsize_anim.jpg"},
    {"name": "Charlie", "avatar": "assets/images/imgpsh_fullsize_anim.jpg"},
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

  if (amount > balanceProvider.balance) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Solde insuffisant")));
    return;
  }

  // Déduire le montant du solde
  balanceProvider.updateBalance(-amount);

  // Ajouter la transaction avec un montant négatif
  transactionProvider.addTransaction(
    name: "$selectedUser",
    amount: -amount,
    icon: Icons.arrow_upward,
  );




  // Ajouter la notification dans la liste des notifications
  // Provider.of<TransactionProvider>(context, listen: false).addTransaction(
  //   "Vous avez envoyé \$${amount.toStringAsFixed(2)} à $selectedUser il y a quelques minutes.",
  // );

  // Afficher une notification temporaire
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Vous avez envoyé \$${amount.toStringAsFixed(2)} à $selectedUser")),
  );

  // Réinitialiser le montant
  setState(() {
    amount = 0;
    selectedUser = "";
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transfert d'argent")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sélectionner un destinataire", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Liste horizontale des utilisateurs
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
            const Text("Montant à envoyer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Affichage du montant sélectionné
            Center(
              child: Text("\$${amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 20),

            // Montants rapides
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
            const Text("Entrer un montant", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

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

            // Bouton d'envoi
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
