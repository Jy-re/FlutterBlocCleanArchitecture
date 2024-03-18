import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../../domain/entities/todo.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  ToDoScreenState createState() => ToDoScreenState();
}

class ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ToDoBloc>().add(GetToDoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ToDoBloc, ToDoState>(
              builder: (context, state) {
                if (state is ToDoListState) {
                  return ListView.builder(
                    itemCount: state.toDos.length,
                    itemBuilder: (context, index) {
                      final toDo = state.toDos[index];
                      return ListTile(
                        title: Text(toDo.title),
                        leading: Text((index + 1).toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ToDoBloc>().add(DeleteTodoEvent(toDo));
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddToDoDialog(context),
        tooltip: 'Add ToDo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddToDoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add New ToDo"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: "ToDo Title"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                final title = _textController.text;
                if (title.isNotEmpty) {
                  final newToDo = ToDo(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: title,
                  );
                  context.read<ToDoBloc>().add(AddToDoEvent(newToDo));
                  Navigator.of(context).pop();
                  _textController.clear();
                }
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
      },
    );
  }
}
