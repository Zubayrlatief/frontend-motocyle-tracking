import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import RegisterScreen
import 'package:frontend_motocycle_tracking/screens/admin_page.dart'; // Import AdminPage

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool isLoggedIn = false; // To track if the user is logged in
  bool isAdmin = false; // To track if the user is an admin

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.containsKey('token'); // Check if token is available
      isAdmin = prefs.getString('userRole') == 'admin'; // Check if the user is an admin
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Motorcycle App"),
      actions: [
        // If the user is logged in, show the profile and admin (if admin)
        if (isLoggedIn) ...[
          if (isAdmin)
            IconButton(
              icon: Icon(Icons.admin_panel_settings), // Admin icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()), // Navigate to AdminPage
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.person), // Profile icon
            onPressed: () {
              // Navigate to profile page
            },
          ),
        ]
        // If the user is not logged in, show login and register options
        else ...[
          IconButton(
            icon: Icon(Icons.person_add), // Register icon
            onPressed: () {
              Navigator.pushNamed(context, '/register'); // Navigate to Register page
            },
          ),
          IconButton(
            icon: Icon(Icons.login), // Login icon
            onPressed: () {
              Navigator.pushNamed(context, '/login'); // Navigate to Login page
            },
          ),
        ],
      ],
    );
  }
}
