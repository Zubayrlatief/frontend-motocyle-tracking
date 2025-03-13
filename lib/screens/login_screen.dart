import 'package:flutter/material.dart';
import 'package:frontend_motocycle_tracking/services/api_service.dart';
import 'home_screen.dart';  // Navigate to HomePage or Dashboard

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  Future<void> login() async {
    try {
      final response = await ApiService.loginUser(
        _emailController.text,
        _passwordController.text,
      );
      String token = response['token'];
      setState(() {
        _message = response['message'];
      });
      // Store the token securely (e.g., using `flutter_secure_storage` package)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(token: token)),
      );
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
