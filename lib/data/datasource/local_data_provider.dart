import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_bloc_clean_architecture/domain/repository/todo_repository.dart';
import '../../domain/entities/todo.dart';
import '../serializers/todo_model.dart';

class SharedPreferenceDataProvider implements ToDoRepository {
  static const String _todoListKey = 'todoList';

  @override
  Future<List<ToDo>> getToDos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonList = prefs.getString(_todoListKey);
    if (jsonList != null) {
      final List<dynamic> decodedList = jsonDecode(jsonList);
      return decodedList.map((e) => ToDoSerialization.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> addToDo(ToDo todo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<ToDo> currentList = await getToDos();
    currentList.add(todo);
    final String encodedList = jsonEncode(
        currentList.map((todo) => ToDoSerialization.toJson(todo)).toList());
    await prefs.setString(_todoListKey, encodedList);
  }

  @override
  Future<void> deleteToDo(ToDo todo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ToDo> currentList = await getToDos();
    currentList.removeWhere((element) => element.id == todo.id);
    final String encodedList = jsonEncode(
        currentList.map((todo) => ToDoSerialization.toJson(todo)).toList());
    await prefs.setString(_todoListKey, encodedList);
  }

  @override
  Future<void> updateToDo(ToDo toDo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ToDo> currentList = await getToDos();
    final index = currentList.indexWhere((element) => element.id == toDo.id);
    if (index >= 0) {
      currentList[index] = toDo;
      final String encodedList = jsonEncode(
          currentList.map((todo) => ToDoSerialization.toJson(todo)).toList());
      await prefs.setString(_todoListKey, encodedList);
    }
  }
}
