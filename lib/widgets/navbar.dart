import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_motocycle_tracking/screens/admin_page.dart'; // Import AdminPage
import 'package:frontend_motocycle_tracking/screens/login_screen.dart'; // Import LoginScreen


class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('token') != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Bike Rentals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [
        isLoggedIn
            ? IconButton(
                icon: Icon(Icons.admin_panel_settings),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                ),
              )
            : TextButton(
                child: Text("Login"),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
              ),
      ],
    );
  }
}
