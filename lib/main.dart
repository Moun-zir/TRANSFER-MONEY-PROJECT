import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfermoneyproject/screens/notifications_screen.dart';
import 'screens/home_screen.dart';
import 'routes/routes.dart';
// import 'screens/transactions_screen.dart';
// import 'screens/notifications_screen.dart';
// import 'screens/settings_screen.dart';
import 'widgets/bottom_nav_bar.dart';
// import 'providers/balance_provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/balance_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => BalanceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Transfer App',
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    // const TransactionsScreen(),
    // const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
