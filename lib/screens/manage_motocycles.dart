import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageMotorcycles extends StatefulWidget {
  @override
  _ManageMotorcyclesState createState() => _ManageMotorcyclesState();
}

class _ManageMotorcyclesState extends State<ManageMotorcycles> {
  List<dynamic> motorcycles = [];

  @override
  void initState() {
    super.initState();
    fetchMotorcycles();
  }

  Future<void> fetchMotorcycles() async {
    final response = await http.get(Uri.parse("http://localhost:5000/motorcycles"));
    if (response.statusCode == 200) {
      setState(() {
        motorcycles = json.decode(response.body)["results"];
      });
    }
  }

  Future<void> deleteMotorcycle(int bikeId) async {
    final response = await http.delete(Uri.parse("http://localhost:5000/motorcycles/$bikeId"));
    if (response.statusCode == 200) {
      fetchMotorcycles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Motorcycles")),
      body: motorcycles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: motorcycles.length,
              itemBuilder: (context, index) {
                var bike = motorcycles[index];
                return ListTile(
                  title: Text("${bike["make"]} ${bike["model"]}"),
                  subtitle: Text("Rate: \$${bike["rental_rate_per_week"]}/week"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteMotorcycle(bike["bike_id"]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/add_motorcycle");
        },
      ),
    );
  }
}
