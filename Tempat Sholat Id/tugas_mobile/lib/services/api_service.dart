import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/record.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/records';

  Future<List<Record>> fetchRecords() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((record) => Record.fromJson(record)).toList();
    } else {
      throw Exception('Failed to load records');
    }
  }

  Future<void> addRecord(Record record) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add record');
    }
  }

  Future<void> updateRecord(String id, Record record) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update record');
    }
  }

  Future<void> deleteRecord(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete record');
    }
  }
}