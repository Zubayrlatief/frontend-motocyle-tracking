import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddMotorcycle extends StatefulWidget {
  @override
  _AddMotorcycleState createState() => _AddMotorcycleState();
}

class _AddMotorcycleState extends State<AddMotorcycle> {
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  Future<void> addMotorcycle() async {
    final response = await http.post(
      Uri.parse("http://localhost:5000/motorcycles"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "make": makeController.text,
        "model": modelController.text,
        "bike_year": int.parse(yearController.text),
        "rental_rate_per_week": rateController.text,
        "rental_status": "available",
        "owner_id": 1
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Motorcycle")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: makeController, decoration: InputDecoration(labelText: "Make")),
            TextField(controller: modelController, decoration: InputDecoration(labelText: "Model")),
            TextField(controller: yearController, decoration: InputDecoration(labelText: "Year")),
            TextField(controller: rateController, decoration: InputDecoration(labelText: "Rate per week")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addMotorcycle, child: Text("Add Motorcycle")),
          ],
        ),
      ),
    );
  }
}
