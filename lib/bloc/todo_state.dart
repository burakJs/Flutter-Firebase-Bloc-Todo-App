import '../models/todo.dart';

abstract class TodoState {
  TodoState();
}

class TodoInitial extends TodoState {
  TodoInitial();
}

class TodoLoading extends TodoState {
  TodoLoading();
}

class TodoSuccess extends TodoState {
  List<Todo>? todos;
  TodoSuccess({this.todos});
}

class TodoError extends TodoState {
  String? error;
  TodoError({this.error});
}
