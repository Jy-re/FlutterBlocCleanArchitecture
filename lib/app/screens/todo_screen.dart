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
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ToDoBloc>().add(GetToDoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.redAccent,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    'TODOLIST',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                      child: Text(
                    'Click on the  to mark as complete',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ToDoBloc, ToDoState>(
              builder: (context, state) {
                if (state is ToDoListState) {
                  return ListView.builder(
                    itemCount: state.toDos.length,
                    itemBuilder: (context, index) {
                      final toDo = state.toDos[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ListTile(
                            title: Text(
                              toDo.title,
                              style: TextStyle(
                                decoration: toDo.isComplete
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            leading: Text((index + 1).toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<ToDoBloc>()
                                    .add(DeleteTodoEvent(toDo));
                              },
                            ),
                            onTap: () {
                              final updatedToDo =
                                  toDo.copyWith(isComplete: !toDo.isComplete);
                              context
                                  .read<ToDoBloc>()
                                  .add(UpdateToDoEvent(updatedToDo));
                            }),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
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
            final toDos = (state as ToDoListState).toDos;
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
                    final title = textController.text;
                    if (title.isNotEmpty) {
                      final newToDo = ToDo(
                        id: toDos.length + 1,
                        title: title,
                        isComplete: false,
                      );
                      context.read<ToDoBloc>().add(AddToDoEvent(newToDo));
                      Navigator.of(context).pop();
                      textController.clear();
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
      },
    );
  }
}
