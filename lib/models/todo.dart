import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  String? id;
  final String todoText;
  final Timestamp createdAt;
  Todo({required this.todoText, required this.createdAt, this.id});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        todoText: json["todoText"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "todoText": todoText,
        "createdAt": createdAt,
      };
}

final List<Todo> dummyList = [
  Todo(todoText: 'Base Todo', createdAt: Timestamp.now()),
];
