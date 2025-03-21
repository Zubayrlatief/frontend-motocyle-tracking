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
        make: _makeController.text,
        model: _modelController.text,
        bikeYear: int.parse(_yearController.text),
        rentalRate: double.parse(_rateController.text), // Convert properly
        engineCC: _engineController.text,
        rentalStatus: "available",
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _makeController,
                decoration: InputDecoration(labelText: "Make"),
                validator: (value) => value!.isEmpty ? "Enter make" : null,
              ),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: "Model"),
                validator: (value) => value!.isEmpty ? "Enter model" : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: "Year"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter year" : null,
              ),
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(labelText: "Rental Rate"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter rate" : null,
              ),
              TextFormField(
                controller: _engineController,
                decoration: InputDecoration(labelText: "Engine CC"),
                validator: (value) => value!.isEmpty ? "Enter engine CC" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text("Add Motorcycle")),
            ],
          ),
        ),
      ),
    );
  }
}
