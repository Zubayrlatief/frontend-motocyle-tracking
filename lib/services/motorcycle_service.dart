import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motorcycle.dart';

class MotorcycleService {
  static const String baseUrl = "http://localhost:5000/motorcycles"; // Your local backend

  // Fetch all motorcycles
  Future<List<Motorcycle>> getMotorcycles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> motorcyclesJson = data['results'];
        return motorcyclesJson.map((json) => Motorcycle.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch motorcycles: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching motorcycles: $e");
    }
  }

  // Fetch a motorcycle by ID
  Future<Motorcycle> getMotorcycleById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        return Motorcycle.fromJson(jsonDecode(response.body)['result']);
      } else {
        throw Exception("Failed to fetch motorcycle: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching motorcycle: $e");
    }
  }
  // Add a new motorcycle
  Future<void> addMotorcycle(Motorcycle motorcycle) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(motorcycle.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to add motorcycle: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding motorcycle: $e");
    }
  }

  // Update a motorcycle
  Future<void> updateMotorcycle(int id, Motorcycle motorcycle) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(motorcycle.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to update motorcycle: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating motorcycle: $e");
    }
  }

  // Delete a motorcycle
  Future<void> deleteMotorcycle(int id) async {
    try {
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode != 200) {
        throw Exception("Failed to delete motorcycle: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error deleting motorcycle: $e");
    }
  }
}
