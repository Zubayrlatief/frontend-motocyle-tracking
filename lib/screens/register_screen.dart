import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  int roleID = 1; // Default to Renter

  Future<void> registerUser() async {
    final url = Uri.parse('http://localhost:5000/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'roleID': roleID
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['msg'])),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['msg'] ?? 'Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: firstNameController, decoration: InputDecoration(labelText: 'First Name')),
            TextField(controller: lastNameController, decoration: InputDecoration(labelText: 'Last Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            DropdownButton<int>(
              value: roleID,
              onChanged: (value) {
                setState(() {
                  roleID = value!;
                });
              },
              items: [
                DropdownMenuItem(value: 1, child: Text('Renter')),
                DropdownMenuItem(value: 2, child: Text('Driver')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: registerUser, child: Text('Register')),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
