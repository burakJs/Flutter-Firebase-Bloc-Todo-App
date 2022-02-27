import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todo_cubit.dart';
import '../../models/todo.dart';
import 'package:kartal/kartal.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        context.read<TodoCubit>().removeTodo(todo);
      },
      direction: DismissDirection.endToStart,
      child: Card(
        child: Padding(
          padding: context.paddingNormal,
          child: Text(
            todo.todoText,
            style: context.textTheme.headline4?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
