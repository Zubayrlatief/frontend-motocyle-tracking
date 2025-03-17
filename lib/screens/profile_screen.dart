import 'package:flutter/material.dart';
import '../models/motorcycle.dart';
import '../services/motorcycle_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final MotorcycleService _service = MotorcycleService();
  List<Motorcycle> _motorcycles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMotorcycles();
  }

  Future<void> _fetchMotorcycles() async {
    try {
      final motorcycles = await _service.getMotorcycles();
      setState(() {
        _motorcycles = motorcycles;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching motorcycles: $e");
    }
  }

  void _deleteMotorcycle(int id) async {
    await _service.deleteMotorcycle(id);
    _fetchMotorcycles(); // Refresh list after deleting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _motorcycles.length,
              itemBuilder: (context, index) {
                final motorcycle = _motorcycles[index];
                return Card(
                  child: ListTile(
                    title: Text("${motorcycle.make} ${motorcycle.model}"),
                    subtitle: Text("Year: ${motorcycle.bikeYear}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteMotorcycle(motorcycle.bikeId),
                    ),
                    onTap: () {
                      // Navigate to update screen (to be implemented)
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to add motorcycle screen (to be implemented)
        },
      ),
    );
  }
}
