class FormDataModel {
  const FormDataModel({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  factory FormDataModel.fromMap(Map<String, dynamic> map) {
    return FormDataModel(
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
