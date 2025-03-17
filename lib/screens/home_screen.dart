import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Motorcycles")),
      body: motorcycles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: motorcycles.length,
              itemBuilder: (context, index) {
                var bike = motorcycles[index];
                return Card(
                  child: Column(
                    children: [
                      Text(bike["make"] + " " + bike["model"]),
                      Text("Year: ${bike["bike_year"]}"),
                      Text("Rate: \$${bike["rental_rate_per_week"]}/week"),
                      Text("Status: ${bike["rental_status"]}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
