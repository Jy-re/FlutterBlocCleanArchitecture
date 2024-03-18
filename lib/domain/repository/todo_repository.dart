import '../entities/todo.dart';

abstract class ToDoRepository {
  Future<List<ToDo>> getToDos();
  Future<void> addToDo(ToDo todo);
  Future<void> deleteToDo(ToDo todo);
}
