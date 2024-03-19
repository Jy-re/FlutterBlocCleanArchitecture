import '../../domain/entities/todo.dart';
import '../../domain/repository/todo_repository.dart';

//IMPORT FOR LOCAL DATA STORAGE
import 'package:todo_bloc_clean_architecture/data/datasource/local_data_provider.dart';

// IMPORT FOR IN MEMORY DATA STORAGE
// import 'package:todo_bloc_clean_architecture/data/datasource/in_memory_data_provider.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  // IN MEMORY DATA STORAGE
  // final InMemoryToDoDataProvider dataProvider;

  // LOCAL DATA STORAGE
  final SharedPreferenceDataProvider dataProvider;

  ToDoRepositoryImpl(this.dataProvider);

  @override
  Future<List<ToDo>> getToDos() async => dataProvider.getToDos();

  @override
  Future<void> addToDo(ToDo todo) async => dataProvider.addToDo(todo);

  @override
  Future<void> deleteToDo(ToDo todo) async => dataProvider.deleteToDo(todo);

  @override
  Future<void> updateToDo(ToDo todo) async {
    await dataProvider.updateToDo(todo);
  }
}
