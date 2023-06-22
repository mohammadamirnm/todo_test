import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo_list/domain/entities/todo.dart';
import 'package:todo_app/src/features/todo_list/presentation/widgets/todo_tile.dart';

import '../cubits/todo/todo_cubit.dart';
import '../widgets/todo_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().fetchTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (BuildContext context, TodoState state) => state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (String message) => Column(
            children: <Widget>[
              const SizedBox(height: 16),
              Text(message),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => context.read<TodoCubit>().fetchTodoList(),
                  child: Text('label_retry'.tr()),
                ),
              ),
            ],
          ),
          loaded: (List<Todo> todos) => ListView.separated(
            itemBuilder: (BuildContext context, int index) => TodoTile(
              todo: todos[index],
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: todos.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => TodoDialog(),
        ),
      ),
    );
  }
}
