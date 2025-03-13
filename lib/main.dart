import 'package:flutter/material.dart';
import 'services/api_service.dart'; // Adjust the path if needed
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
        // You can customize the primary color scheme here
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',  // Default route to the HomeScreen
      routes: {
        '/': (context) => HomeScreen(token: '',),  // Make sure this references the correct widget
        '/admin': (context) => AdminPage(),
        '/login': (context) => LoginScreen(),
        '/rental': (context) => RentalPage(),
      },
      // You can also add a navigator observer here if you plan on handling routing more extensively
    );
  }
}

class LoginScreen {
}

class RegisterScreen {
}
