import 'package:flutter/material.dart';
import 'package:school_app/utils/extensions/string_extension.dart';

class ClassModel {
  final int? id;
  final String name;
  final String? room;
  final Color color;


  const ClassModel({
    this.id,
    required this.name,
    this.room,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          room == other.room &&
          color == other.color);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ room.hashCode ^ color.hashCode;

  @override
  String toString() {
    return 'ClassModel{ id: $id, name: $name, room: $room, color: $color,}';
  }

  ClassModel copyWith({
    int? id,
    String? name,
    String? room,
    Color? color,
  }) {
    return ClassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_id': id,
      'name': name,
      'room': room,
      'color': color.toHexTriplet,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['class_id'] as int,
      name: map['name'] as String,
      room: map['room'] as String,
      color: (map['color'] as String).color,
    );
  }
}

List<String> classesColor = ['FF5733', '33FF57', '3357FF', 'F0A020', '20F0A0', 'A020F0', 'FFB6C1', '800080', 'FFD700', '008080'];