class Task {
  final int? id;
  final String title;
  final String description;
  final String dateCreated;
  final String dueDate;
  final bool isCompleted;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.dateCreated,
      required this.dueDate,
      this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateCreated': dateCreated,
      'dueDate': dueDate,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateCreated: map['dateCreated'],
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  Task copyWith({bool? isCompleted}) {
    return Task(
      id: this.id,
      title: this.title,
      description: this.description,
      dateCreated: this.dateCreated,
      dueDate: this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
