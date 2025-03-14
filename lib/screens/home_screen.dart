import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: NavBar(),
      body: Center(
        child: Text('Welcome to Motorcycle Tracking App!'),
      ),
    );
  }
}
