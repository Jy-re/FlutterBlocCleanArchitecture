import '../../domain/entities/todo.dart';

abstract class ToDoState {}

class ToDoInitialState extends ToDoState {}

class ToDoListState extends ToDoState {
  final List<ToDo> toDos;

  ToDoListState(this.toDos);
}
