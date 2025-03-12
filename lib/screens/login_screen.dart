import 'package:flutter/material.dart';
import 'package:frontend_motocycle_tracking/screens/home_screen.dart'; // Ensure this import is correct

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Your login logic goes here
  void _loginUser() {
    // Once the user is logged in successfully:
    Navigator.pushReplacementNamed(context, '/'); // Navigate to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: _loginUser,
          child: Text("Login"),
        ),
      ),
    );
  }
}
