import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../../domain/entities/todo.dart';

class AddToDoDialog extends StatefulWidget {
  final List<ToDo> todos;

  const AddToDoDialog({super.key, required this.todos});

  @override
  AddToDoDialogState createState() => AddToDoDialogState();
}

class AddToDoDialogState extends State<AddToDoDialog> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New ToDo"),
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: "ToDo Title"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            addNewToDoItem(context);
          },
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void addNewToDoItem(BuildContext context) {
    final String title = textController.text;
    if (title.isNotEmpty) {
      final newToDo = ToDo(
        id: widget.todos.length + 1,
        title: title,
        isComplete: false,
      );
      context.read<ToDoBloc>().add(AddToDoEvent(newToDo));
      Navigator.of(context).pop();
      textController.clear();
    }
  }
}
