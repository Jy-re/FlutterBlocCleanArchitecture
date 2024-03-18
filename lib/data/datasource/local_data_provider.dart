import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc_clean_architecture/domain/repository/todo_repository.dart';
import '../../domain/entities/todo.dart';

class SharedPreferenceDataProvider implements ToDoRepository {
  static const String _todoListKey = 'todoList';

  @override
  Future<List<ToDo>> getToDos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonList = prefs.getString(_todoListKey);
    if (jsonList != null) {
      final List<dynamic> decodedList = jsonDecode(jsonList);
      return decodedList.map((e) => ToDo.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> addToDo(ToDo todo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<ToDo> currentList = await getToDos();
    currentList.add(todo);
    final String encodedList = jsonEncode(currentList);
    await prefs.setString(_todoListKey, encodedList);
  }

  @override
  Future<void> deleteToDo(ToDo todo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ToDo> currentList = await getToDos();
    currentList.removeWhere((element) => element.id == todo.id);
    final String encodedList = jsonEncode(currentList);
    await prefs.setString(_todoListKey, encodedList);
  }
}
