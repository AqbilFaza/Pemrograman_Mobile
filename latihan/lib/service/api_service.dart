import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan/model/todos.dart';

class ApiService {
  static Future<Todo> getTodo() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/todos/5"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Todo.fromJson(data);
    } else {
      throw Exception('Failed to load todo');
    }
  }
}