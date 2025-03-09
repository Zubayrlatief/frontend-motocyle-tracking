import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import HomeScreen
import 'screens/admin_page.dart'; // Import AdminPage
import 'screens/login_screen.dart'; // Import LoginScreen
import 'screens/register_screen.dart'; // Import RegisterScreen
import 'screens/rental_page.dart'; // Import RentalPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Motorcycle Tracking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/', // Set the default route
      routes: {
        '/': (context) => HomeScreen(), // Default screen
        '/admin': (context) => AdminPage(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/rental': (context) => RentalPage(),
      },
    );
  }
}
