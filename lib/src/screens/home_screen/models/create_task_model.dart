class CreateTaskModel {
  const CreateTaskModel({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  factory CreateTaskModel.fromMap(Map<String, dynamic> map) {
    return CreateTaskModel(
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
