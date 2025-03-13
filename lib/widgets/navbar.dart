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
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
      child: AppBar(
        title: const Text(
          "Motorcycle App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        actions: [
          if (isLoggedIn) ...[
            if (isAdmin)
              IconButton(
                icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  );
                },
              ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // Navigate to profile page
              },
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.person_add, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            IconButton(
              icon: const Icon(Icons.login, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ],
      ),
    );
  }
}
