import '../../domain/entities/todo.dart';

abstract class ToDoEvent {}

class GetToDoEvent extends ToDoEvent {}

class AddToDoEvent extends ToDoEvent {
  final ToDo todo;

  AddToDoEvent(this.todo);
}

class DeleteTodoEvent extends ToDoEvent {
  final ToDo todo;

  DeleteTodoEvent(this.todo);
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDo todo;

  UpdateToDoEvent(this.todo);
}
