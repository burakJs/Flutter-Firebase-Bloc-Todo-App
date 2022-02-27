import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../bloc/todo_cubit.dart';
import '../../../bloc/todo_state.dart';
import '../../../models/todo.dart';
import '../../../product/cards/todo_card.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final String _initialText = 'INITIAL STATE';
  final String _errorText = 'BASE ERROR';
  final String _addButtonText = 'ADD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: _todoTextField(context),
                    ),
                    const Spacer(),
                    _addTodoButton(context)
                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    if (state is TodoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TodoInitial) {
                      return Center(child: Text(_initialText));
                    } else if (state is TodoSuccess) {
                      var todoList = state.todos ?? dummyList;
                      return ListView.builder(
                        itemCount: todoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TodoCard(todo: todoList[index]);
                        },
                      );
                    } else {
                      return Center(child: Text((state as TodoError).error ?? _errorText));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _addTodoButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<TodoCubit>().addTodo(Todo(todoText: _controller.text.trim(), createdAt: Timestamp.now()));
        _controller.text = '';
      },
      child: Text(_addButtonText),
    );
  }

  TextField _todoTextField(BuildContext context) {
    return TextField(
      controller: _controller,
      style: context.textTheme.titleSmall,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: context.normalValue),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
