import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/utils/extensions/string_extension.dart';

class ScheduleModel {
  final int id;
  final String title;
  final String room;
  final Color color;
  final int classId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final List<AssignmentModel> assignments;

  DateTime get completeStartTime => DateTime(
    date.year,
    date.month,
    date.day,
    startTime.hour,
    startTime.minute,
    startTime.second,
  );

  DateTime get completeEndTime => DateTime(
    date.year,
    date.month,
    date.day,
    endTime.hour,
    endTime.minute,
    endTime.second,
  );


//<editor-fold desc="Data Methods">
  const ScheduleModel({
    required this.id,
    required this.title,
    required this.room,
    required this.color,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.assignments,
    required this.classId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          room == other.room &&
          color == other.color &&
          date == other.date &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          assignments == other.assignments);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      room.hashCode ^
      color.hashCode ^
      date.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      assignments.hashCode;


  ScheduleModel copyWith({
    int? id,
    String? title,
    String? room,
    Color? color,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    List<AssignmentModel>? assignments,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      room: room ?? this.room,
      color: color ?? this.color,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      assignments: assignments ?? this.assignments,
      classId: classId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_id': id,
      'title': title,
      'room': room,
      'color': color.value.toString(), // Convert Color to an integer string
      'date': date.toIso8601String().split('T').first, // Store as 'YYYY-MM-DD'
      'start_time': startTime.toIso8601String().split('T').last, // Store as 'HH:MM:SS'
      'end_time': endTime.toIso8601String().split('T').last, // Store as 'HH:MM:SS'
      // Assignments are not included directly; handle separately as a list in a different table
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    String todayDateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return ScheduleModel(
      id: map['schedule_id'],
      title: map['title'] ?? '',
      room: map['room'] ?? '',
      color: (map['color'] as String).color, // Default to black color if null
      date: DateTime.parse(map['date']), // Parse ISO 8601 date string
      startTime: DateTime.parse('$todayDateString ${map['start_time']}'), // Parse ISO 8601 time string
      endTime: DateTime.parse('$todayDateString ${map['end_time']}'), // Parse ISO 8601 time string
      classId: map['class_id'],
      assignments: (map['assignments'] as List<dynamic>?)
          ?.map((item) => AssignmentModel.fromMap(item))
          .toList() ??
          [],

    );
  }

  @override
  String toString() {
    return 'ScheduleModel{id: $id, title: $title, room: $room, color: $color, date: $date, startTime: $startTime, endTime: $endTime, assignments: $assignments}';
  }

//</editor-fold>
}