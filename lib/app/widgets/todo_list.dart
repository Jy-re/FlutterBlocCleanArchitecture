import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';
import 'todo_item.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (context, state) {
        if (state is ToDoListState) {
          return ListView.builder(
            itemCount: state.toDos.length,
            itemBuilder: (context, index) {
              final todo = state.toDos[index];
              return ToDoListItem(todo: todo, index: index);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
