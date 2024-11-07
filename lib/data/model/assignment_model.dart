class AssignmentModel {
  final int? id; // Auto-incremented, nullable before insertion
  final int scheduleId;
  final String title;
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;


  AssignmentModel({
    this.id,
    required this.scheduleId,
    required this.title,
    required this.description,
    this.dueDate,
    required this.isCompleted,
  });

//</e@override
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is AssignmentModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              scheduleId == other.scheduleId &&
              title == other.title &&
              description == other.description &&
              dueDate == other.dueDate &&
              isCompleted == other.isCompleted
          );


  @override
  int get hashCode =>
      id.hashCode ^
      scheduleId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      dueDate.hashCode ^
      isCompleted.hashCode;




  AssignmentModel copyWith({
    int? id,
    int? scheduleId,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }


  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['assignment_id'],
      scheduleId: map['schedule_id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date']) : null,
      isCompleted: (map['completed'] ?? 0) == 1,
    );
  }

  // Method to convert an AssignmentModel instance to a map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'assignment_id': id,
      'schedule_id': scheduleId,
      'title': title,
      'description': description,
      'due_date': dueDate?.toIso8601String().split('T').first, // Store as 'YYYY-MM-DD'
      'completed': isCompleted ? 1 : 0, // Store boolean as integer (1 or 0)
    };
  }

  @override
  String toString() {
    return 'AssignmentModel{id: $id, scheduleId: $scheduleId, title: $title, description: $description, dueDate: $dueDate, isCompleted: $isCompleted}';
  }
}