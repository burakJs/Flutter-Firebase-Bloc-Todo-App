import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/ITodo_repository.dart';
import 'repository/todo_repository.dart';
import 'todo_state.dart';

import '../models/todo.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit({ITodoRepository? todoRepository})
      : _todoRepository = todoRepository ?? TodoRepository(),
        super(TodoInitial());

  final ITodoRepository _todoRepository;

  Future<void> getAllTodo() async {
    emit(TodoLoading());
    final results = await _todoRepository.getAllTodos();
    emit(TodoSuccess(todos: results));
  }

  Future<void> addTodo(Todo todo) async {
    if (todo.todoText.isEmpty) return;
    emit(TodoLoading());
    await _todoRepository.addTodo(todo);
    final results = await _todoRepository.getAllTodos();
    emit(TodoSuccess(todos: results));
  }

  Future<void> removeTodo(Todo todo) async {
    emit(TodoLoading());
    await _todoRepository.removeTodo(todo);
    final results = await _todoRepository.getAllTodos();
    emit(TodoSuccess(todos: results));
  }
}
