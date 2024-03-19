import 'package:todo_bloc_clean_architecture/domain/repository/todo_repository.dart';
import '../../domain/entities/todo.dart';

class InMemoryToDoDataProvider implements ToDoRepository {
  final List<ToDo> _toDos = [];

  @override
  Future<List<ToDo>> getToDos() async {
    return _toDos;
  }

  @override
  Future<void> addToDo(ToDo todo) async {
    _toDos.add(todo);
  }

  @override
  Future<void> deleteToDo(ToDo todo) async {
    _toDos.removeWhere((element) => element.id == todo.id);
  }

  @override
  Future<void> updateToDo(ToDo toDo) async {
    final index = _toDos.indexWhere((element) => element.id == toDo.id);
    if (index >= 0) {
      _toDos[index] = toDo;
    }
  }
}
