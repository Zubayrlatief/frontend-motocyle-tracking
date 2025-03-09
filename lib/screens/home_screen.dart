import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rental_page.dart';
import 'admin_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userRole = '';

  @override
  void initState() {
    super.initState();
    checkUserRole();
  }

  Future<void> checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('role') ?? 'user';
    });
  }

  @override
  Widget build(BuildContext context) {
    return userRole == 'renter' ? AdminPage() : RentalPage();
  }
}
