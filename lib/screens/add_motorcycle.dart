import 'package:flutter/material.dart';
import '../models/motorcycle.dart';
import '../services/motorcycle_service.dart';

class AddMotorcycleScreen extends StatefulWidget {
  @override
  _AddMotorcycleScreenState createState() => _AddMotorcycleScreenState();
}

class _AddMotorcycleScreenState extends State<AddMotorcycleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = MotorcycleService();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _rateController = TextEditingController();
  final _engineController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final motorcycle = Motorcycle(
        bikeId: 0,
        make: _makeController.text,
        model: _modelController.text,
        bikeYear: int.parse(_yearController.text),
        rentalRate: _rateController.text,
        engineCC: _engineController.text,
        rentalStatus: "available",
        ownerId: 1, // Replace with actual owner ID
      );
      await _service.addMotorcycle(motorcycle);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Motorcycle")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(controller: _makeController, decoration: InputDecoration(labelText: "Make")),
            TextFormField(controller: _modelController, decoration: InputDecoration(labelText: "Model")),
            TextFormField(controller: _yearController, decoration: InputDecoration(labelText: "Year")),
            TextFormField(controller: _rateController, decoration: InputDecoration(labelText: "Rental Rate")),
            ElevatedButton(onPressed: _submit, child: Text("Add Motorcycle")),
          ],
        ),
      ),
    );
  }
}
