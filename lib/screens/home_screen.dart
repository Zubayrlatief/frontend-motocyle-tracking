import 'package:flutter/material.dart';
import '/services/api_service.dart';


class HomeScreen extends StatelessWidget {
  final String token;

  HomeScreen({required this.token});

  Future<void> fetchProtectedData() async {
    try {
      final response = await ApiService.getProtectedData(token);
      print('Protected Data: $response');
    } catch (e) {
      print('Error fetching protected data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchProtectedData(); // Call the function to get data when the page is loaded

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Home Page!'),
            ElevatedButton(
              onPressed: () {
                // Handle logout here
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
