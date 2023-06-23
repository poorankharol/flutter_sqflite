class Note {
  final int? id;
  final String title;
  final String description;

  Note({this.id, required this.title, required this.description});

  Note.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        title = item["title"],
        description = item["description"];

  Map<String, Object?> toMap() {
    return {'id': id, 'description': description, 'title': title};
  }
}
