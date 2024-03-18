import '../../domain/entities/todo.dart';

class ToDoSerialization {
  static ToDo fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
    );
  }

  static Map<String, dynamic> toJson(ToDo todo) {
    return {
      'id': todo.id,
      'title': todo.title,
    };
  }
}
