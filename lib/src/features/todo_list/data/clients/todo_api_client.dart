import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/src/features/todo_list/data/models/todo_model.dart';

import '../exceptions/todo_api_exceptions.dart';

class TodoApiClient {
  TodoApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = 'jsonplaceholder.typicode.com';
  final http.Client _httpClient;

  Future<List<TodoModel>> getTodoModels() async {
    final Uri todoRequest = Uri.https(
      _baseUrl,
      '/todos',
      <String, String>{'userId': '1'},
    );

    final http.Response response = await _httpClient.get(
      todoRequest,
    );

    if (response.statusCode >= 300) {
      throw TodoRequestFailed();
    }

    final List<TodoModel> todoModels = todoModelsFromJson(response.body);

    return todoModels;
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    final Uri todoRequest = Uri.parse('https://$_baseUrl/todos');

    final http.Response response = await http.post(
      todoRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(todoModel.toJson()),
    );

    if (response.statusCode >= 300 || response.body.isEmpty) {
      throw TodoRequestFailed();
    }
  }
}
