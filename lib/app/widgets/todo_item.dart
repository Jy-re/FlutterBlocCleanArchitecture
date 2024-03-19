import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

import '../../domain/entities/todo.dart';

class ToDoListItem extends StatelessWidget {
  final ToDo todo;
  final int index;

  const ToDoListItem({super.key, required this.index, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isComplete
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Text((index + 1).toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            context.read<ToDoBloc>().add(DeleteTodoEvent(todo));
          },
        ),
        onTap: () {
          final updatedToDo = todo.copyWith(isComplete: !todo.isComplete);
          context.read<ToDoBloc>().add(UpdateToDoEvent(updatedToDo));
        },
      ),
    );
  }
}
