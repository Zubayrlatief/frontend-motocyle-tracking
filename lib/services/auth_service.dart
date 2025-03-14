import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "btdkvpqextwmybj06nul-mysql.services.clever-cloud.com";  // Change this to your backend URL

  Future<String?> registerUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 201) {
        return "Registration Successful";
      } else {
        return "Registration Failed: ${jsonDecode(response.body)['message']}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
