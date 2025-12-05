enum DeadlineType { vat, paye, wht, pension, incomeTax, advanceTax }

class Deadline {
  final String id;
  final DeadlineType type;
  final DateTime dueDate;
  final String title;
  final String description;
  final bool isDone;

  Deadline({
    required this.id,
    required this.type,
    required this.dueDate,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Deadline copyWith({bool? isDone}) {
    return Deadline(
      id: id,
      type: type,
      dueDate: dueDate,
      title: title,
      description: description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type.name,
    "due_date": dueDate.toIso8601String(),
    "title": title,
    "description": description,
    "is_done": isDone,
  };
}