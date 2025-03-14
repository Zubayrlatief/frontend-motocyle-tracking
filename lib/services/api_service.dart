import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "btdkvpqextwmybj06nul-mysql.services.clever-cloud.com"; // Update this with your backend URL

  // REGISTER USER
  static Future<Map<String, dynamic>> registerUser(String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "emailAdd": email,
        "userPass": password
      }),
    );

    return jsonDecode(response.body);
  }

  // LOGIN USER
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "emailAdd": email,
        "userPass": password
      }),
    );

    return jsonDecode(response.body);
  }
}
