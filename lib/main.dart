import 'package:flutter/material.dart';
<<<<<<< HEAD
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

=======
import 'package:transfermoneyproject/login_page.dart';
import 'package:transfermoneyproject/register_page.dart';
import 'screens/accueil_screen.dart'; // Assure-toi d'importer la bonne page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
>>>>>>> 6f019fbe24e51856080e97c5b6fab9a59eeadd58
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
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
=======
      initialRoute: '/', //(Page d'entrée , la page principale)
      routes: {
        '/':(context) => IntroScreen(),//Page d'introduction
        '/register': (context) => RegisterPage(), //Page d'inscription
        '/login': (context) => LoginPage(), //Page de connexion
        // '/home':(context) => AccueilScreen()
      },
>>>>>>> 6f019fbe24e51856080e97c5b6fab9a59eeadd58
    );
  }
}
