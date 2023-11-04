class UpdateTaskModel {
  const UpdateTaskModel({
    required this.title,
    required this.description,
    required this.isDone,
  });

  final String title;
  final String description;
  final bool isDone;

  factory UpdateTaskModel.fromMap(Map<String, dynamic> map) {
    final isDoneValue = map['is_done'];

    return UpdateTaskModel(
      title: map['title'],
      description: map['description'],
      isDone: isDoneValue == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'is_done': isDone ? 1 : 0,
    };
  }
}
