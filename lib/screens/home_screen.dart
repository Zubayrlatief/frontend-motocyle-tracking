import 'package:flutter/material.dart';
import 'package:frontend_motocycle_tracking/widgets/navbar.dart';  // Ensure correct import
import 'package:shared_preferences/shared_preferences.dart';
import 'rental_page.dart';
import 'admin_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: <Widget>[
          Navbar(),  // Add your Navbar here
          Expanded(
            child: Center(
              child: Text('Welcome to the Home Screen!'),
            ),
          ),
        ],
      ),
    );
  }
}
