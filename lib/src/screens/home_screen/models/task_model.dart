class TaskModel {
  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  final String id;
  final String title;
  final String description;
  final bool isDone;

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['is_done'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
