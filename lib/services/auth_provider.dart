import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;

  // CHECK LOGIN STATUS
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");

    print("Checking login status... Token found: $_token"); // Debugging

    if (_token != null) {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  // LOGIN USER
  Future<void> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    print("Token saved: $token"); // Debugging
    _isLoggedIn = true;
    notifyListeners();
  }

  // LOGOUT USER
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    print("User logged out, token removed"); // Debugging
    _isLoggedIn = false;
    notifyListeners();
  }
}
