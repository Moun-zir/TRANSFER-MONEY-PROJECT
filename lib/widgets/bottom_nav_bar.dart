import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 245, 243, 243),
      currentIndex: selectedIndex,
      onTap: onTap,
      iconSize: 30,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.green,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.window),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Transaction',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   label: 'Settings',
        // ),
      ],
    );
  }
}
