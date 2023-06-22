import 'package:todo_app/src/features/todo_list/data/models/todo_model.dart';

import '../../domain/entities/todo.dart';
import '../clients/todo_api_client.dart';

class TodoRepository {
  TodoRepository({
    TodoApiClient? todoApiClient,
  }) : _todoApiClient = todoApiClient ?? TodoApiClient();

  final TodoApiClient _todoApiClient;

  Future<List<Todo>> getTodos() async {
    final List<TodoModel> todoModels = await _todoApiClient.getTodoModels();

    final List<Todo> todos = _convertToTodos(todoModels);

    return todos;
  }

  Future<void> updateTodo(Todo todo) async {
    final TodoModel todoModel = _convertToModel(todo);

    await _todoApiClient.updateTodo(todoModel);
  }

  List<Todo> _convertToTodos(List<TodoModel> todoModels) {
    // This looks redundant in this case but it is the step to change the model from the data side to the domain side entity that we can use.
    final List<Todo> todos = <Todo>[];
    for (TodoModel todoModel in todoModels) {
      todos.add(
        Todo(
          id: todoModel.id ?? 0,
          title: todoModel.title ?? '',
          completed: todoModel.completed ?? false,
        ),
      );
    }

    return todos;
  }

  TodoModel _convertToModel(Todo todo) {
    final TodoModel todoModel = TodoModel(
        userId: 1, id: todo.id, title: todo.title, completed: todo.completed);

    return todoModel;
  }
}
