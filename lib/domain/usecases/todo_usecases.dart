import '../repository/todo_repository.dart';
import '../entities/todo.dart';

class AddToDoUseCase {
  final ToDoRepository repository;

  AddToDoUseCase(this.repository);

  Future<void> call(ToDo todo) async {
    await repository.addToDo(todo);
  }
}

class GetToDoUseCase {
  final ToDoRepository repository;

  GetToDoUseCase(this.repository);

  Future<List<ToDo>> call() async {
    return await repository.getToDos();
  }
}

class DeleteTodoUseCase {
  final ToDoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<void> call(ToDo todo) async {
    await repository.deleteToDo(todo);
  }
}

class UpdateToDoUseCase {
  final ToDoRepository repository;

  UpdateToDoUseCase(this.repository);

  Future<void> call(ToDo todo) async {
    await repository.updateToDo(todo);
  }
}
