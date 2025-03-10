import 'package:flutter/material.dart';
import 'screens/home_screen.dart';  // Ensure this import is correct
import 'screens/admin_page.dart'; 
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/rental_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Removes the debug banner
      title: 'Motorcycle Tracking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',  // Default route
      routes: {
        '/': (context) => const HomeScreen(),  // Make sure this references the correct widget
        '/admin': (context) => AdminPage(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/rental': (context) => RentalPage(),
      },
    );
  }
}
