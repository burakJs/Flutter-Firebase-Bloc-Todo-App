import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../models/todo.dart';

abstract class ITodoRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Todo>> getAllTodos();
  Future<void> addTodo(Todo todo);
  Future<void> removeTodo(Todo todo);
}
