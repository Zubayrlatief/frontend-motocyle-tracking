import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';  // Replace with your backend URL

  // Register User
  static Future<Map<String, dynamic>> registerUser(
      String firstName,
      String lastName,
      String email,
      String password,
      String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  // Login User
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Returns JWT token and message
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Example of making an authenticated request
  static Future<Map<String, dynamic>> getProtectedData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch protected data');
    }
  }
}
