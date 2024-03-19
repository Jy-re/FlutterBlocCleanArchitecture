import '../../domain/entities/todo.dart';

class ToDoSerialization {
  static ToDo fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
      isComplete: json['isComplete'] ?? false,
    );
  }

  static Map<String, dynamic> toJson(ToDo todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'isComplete': todo.isComplete,
    };
  }
}
