import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "backendmotocycletracker.c5o8mw02w173.eu-north-1.rds.amazonaws.com"; // Your backend URL

  // ✅ Login Function
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      String role = data['role']; // Expecting 'renter' or 'user'

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('role', role);

      return true; // Login successful
    }
    return false; // Login failed
  }

  // ✅ Register Function
  Future<bool> register(String firstName, String lastName, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role // 'renter' or 'user'
      }),
    );

    return response.statusCode == 201; // Registration successful
  }

  // ✅ Logout Function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
  }

  // ✅ Get User Role
  Future<String> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role') ?? 'user'; // Default to 'user'
  }
}
