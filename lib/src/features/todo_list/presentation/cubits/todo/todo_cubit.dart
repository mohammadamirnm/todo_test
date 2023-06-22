import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/src/exceptions/failure.dart';
import 'package:todo_app/src/features/todo_list/data/repositories/todo_repository.dart';

import '../../../domain/entities/todo.dart';

part 'todo_state.dart';
part 'todo_cubit.freezed.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({TodoRepository? todoRepository})
      : _todoRepository = todoRepository ?? TodoRepository(),
        super(const TodoState.initial());

  final TodoRepository _todoRepository;

  final List<Todo> todos = <Todo>[];

  Future<void> fetchTodoList() async {
    emit(const TodoState.loading());

    try {
      todos.clear();
      todos.addAll(await _todoRepository.getTodos());
      emit(TodoState.loaded(todos));
    } on Failure catch (f) {
      emit(TodoState.error(f.message ?? 'label_unknown_error'.tr()));
    } catch (e) {
      emit(TodoState.error(e.toString()));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todoRepository.updateTodo(todo);
      final int index = todos.indexWhere((Todo item) => item.id == todo.id);
      todos[index] = todo;
      emit(TodoState.loaded(todos));
    } on Failure catch (f) {
      emit(TodoState.error(f.message ?? 'label_unknown_error'.tr()));
    } catch (e) {
      emit(TodoState.error(e.toString()));
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      emit(const TodoState.loading());
      await _todoRepository.updateTodo(todo);
      todos.add(todo);
      emit(TodoState.loaded(todos));
    } on Failure catch (f) {
      emit(TodoState.error(f.message ?? 'label_unknown_error'.tr()));
    } catch (e) {
      emit(TodoState.error(e.toString()));
    }
  }
}
