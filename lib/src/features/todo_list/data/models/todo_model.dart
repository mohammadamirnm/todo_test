import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}

List<TodoModel> todoModelsFromJson(String str) =>
    List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));
