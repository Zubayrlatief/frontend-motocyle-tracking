import 'package:flutter/material.dart';

class RentalPage extends StatelessWidget {
  const RentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rental Page")),
      body: Column(
        children: [
          Text("This is the Rental Page"),
          ElevatedButton(
            onPressed: () {
              // Implement bike adding functionality later
            },
            child: Text("Add a Motorcycle (For Renters)"),
          ),
        ],
      ),
    );
  }
}
