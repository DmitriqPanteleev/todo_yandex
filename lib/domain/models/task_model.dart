import 'package:flutter/material.dart';

enum Importance { low, basic, high }

class TaskModel {
  final String id;
  final String text;
  final Importance importance;
  final DateTime? deadline;
  final bool done;
  final Color? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String lastUpdatedBy;

  const TaskModel({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    required this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  static String get _uniqueId =>
      DateTime.now().toUtc().millisecondsSinceEpoch.toString();

  factory TaskModel.empty() => TaskModel(
        id: _uniqueId,
        text: "",
        importance: Importance.basic,
        deadline: null,
        done: false,
        color: null,
        createdAt: DateTime.now(),
        changedAt: DateTime.now(),
        lastUpdatedBy: '1',
      );

  TaskModel copyWith({
    String? id,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    Color? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) =>
      TaskModel(
        id: id ?? this.id,
        text: text ?? this.text,
        importance: importance ?? this.importance,
        deadline: deadline ?? this.deadline,
        done: done ?? this.done,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        changedAt: changedAt ?? this.changedAt,
        lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      );
}
