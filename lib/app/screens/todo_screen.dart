import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/todo_dialog.dart';
import '../widgets/todo_header.dart';
import '../widgets/todo_list.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  ToDoScreenState createState() => ToDoScreenState();
}

class ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ToDoBloc>().add(GetToDoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToDoHeader(),
          Expanded(child: ToDoList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () => showAddToDoDialog(context),
        tooltip: 'Add ToDo',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void showAddToDoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ToDoBloc, ToDoState>(
          builder: (context, state) {
            final todos = (state as ToDoListState).toDos;
            return AddToDoDialog(todos: todos);
          },
        );
      },
    );
  }
}
