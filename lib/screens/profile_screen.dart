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
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchMotorcycles();
  }

  // Fetch motorcycles from the service
  Future<void> _fetchMotorcycles() async {
    try {
      final motorcycles = await _service.getMotorcycles();
      setState(() {
        _motorcycles = motorcycles;
        isLoading = false;
        errorMessage = null; // Reset error message on success
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching motorcycles: $e";
        isLoading = false;
      });
    }
  }

  // Delete a motorcycle
  void _deleteMotorcycle(int? id) async {
    if (id != null) {
      try {
        await _service.deleteMotorcycle(id);
        _fetchMotorcycles(); // Refresh list after deleting
      } catch (e) {
        setState(() {
          errorMessage = "Failed to delete motorcycle: $e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : ListView.separated(
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
                          // Navigate to update screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateMotorcycleScreen(motorcycle: motorcycle),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(), // Add space between items
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to add motorcycle screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMotorcycleScreen()),
          );
        },
      ),
    );
  }
}

// Sample placeholder for UpdateMotorcycleScreen
class UpdateMotorcycleScreen extends StatelessWidget {
  final Motorcycle motorcycle;
  UpdateMotorcycleScreen({required this.motorcycle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Motorcycle")),
      body: Center(child: Text("Update form for ${motorcycle.make} ${motorcycle.model}")),
    );
  }
}

// Sample placeholder for AddMotorcycleScreen
class AddMotorcycleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Motorcycle")),
      body: Center(child: Text("Add motorcycle form goes here")),
    );
  }
}
