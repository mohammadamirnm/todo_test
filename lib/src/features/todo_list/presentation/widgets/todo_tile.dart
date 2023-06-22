import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo_list/presentation/cubits/todo/todo_cubit.dart';

import '../../domain/entities/todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.todo.title),
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? value) {
          setState(() {
            widget.todo.completed = value ?? false;
          });
          context.read<TodoCubit>().updateTodo(widget.todo);
        },
      ),
    );
  }
}
