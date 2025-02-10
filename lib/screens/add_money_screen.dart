import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  _AddMoneyScreenState createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  String amount = "";
  int selectedCardIndex = 0;

  void _onKeyPressed(String value) {
    setState(() {
      if (value == "X") {
        if (amount.isNotEmpty) {
          amount = amount.substring(0, amount.length - 1);
        }
      } else {
        amount += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final cards = balanceProvider.cards;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Money")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCardIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selectedCardIndex == index ? Colors.blue : Colors.grey[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cards[index]['title'],
                          style: TextStyle(
                            color: selectedCardIndex == index ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cards[index]['number'],
                          style: TextStyle(
                            color: selectedCardIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${cards[index]['balance'].toStringAsFixed(2)}",
                          style: TextStyle(
                            color: selectedCardIndex == index ? Colors.white : Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 70),
          const Text("Enter Amount", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text("\$${amount.isEmpty ? '0' : amount}",
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(child: _buildNumPad()),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (amount.isNotEmpty) {
                  double value = double.tryParse(amount) ?? 0;
                  if (value > 0) {
                    balanceProvider.addMoney(value, selectedCardIndex, context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("✅ Added \$${amount} to ${cards[selectedCardIndex]['title']}"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                }
              },
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color of the button
                // minimumSize: Size(double.infinity, 100), // Button width and height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // No round corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: const Text("Send", 
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Bold text
                )
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNumPad() {
    final keys = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      [".", "0", "X"]
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ 3;
        final col = index % 3;
        final value = keys[row][col];

        return ElevatedButton(
          onPressed: () => _onKeyPressed(value),
          child: Text(value, style: const TextStyle(fontSize: 22)),
        );
      },
    );
  }
}
