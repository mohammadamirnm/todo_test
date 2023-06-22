import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/features/todo_list/domain/entities/todo.dart';
import 'package:todo_app/src/features/todo_list/presentation/cubits/todo/todo_cubit.dart';

class TodoDialog extends StatelessWidget {
  TodoDialog({super.key});

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('label_enter_title'.tr()),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          hintText: 'label_enter_title'.tr(),
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('label_submit'.tr()),
          onPressed: () {
            context.read<TodoCubit>().addTodo(
                  Todo(
                    id: Random().nextInt(1000),
                    title: _textFieldController.text,
                    completed: false,
                  ),
                );
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
