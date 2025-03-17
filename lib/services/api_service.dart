import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000"; // Change this if needed

  // REGISTER USER
  static Future<Map<String, dynamic>> registerUser(
      String firstName, String lastName, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'), // Ensure this is your correct API URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "emailAdd": email,
        "userPass": password,
        "userRole": role
      }),
    );

    return jsonDecode(response.body);
  }

  // LOGIN USER
  static Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "emailAdd": email,
        "userPass": password
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data["token"];

      // Save token to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }

  // LOGOUT USER
  static Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}
