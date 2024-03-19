class ToDo {
  final int id;
  final String title;
  late final bool isComplete;

  ToDo({
    required this.id,
    required this.title,
    required this.isComplete,
  });

  ToDo copyWith({int? id, String? title, bool? isComplete}) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
