class Todo {
  int? id;
  String title;
  int completed = 0;

  Todo(this.title);

  Todo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map["title"],
        completed = map['completed'];

  Map<String, dynamic> toMap() {
    return {'title': title, 'completed': completed};
  }
}
