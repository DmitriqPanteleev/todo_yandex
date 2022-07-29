import 'package:flutter/material.dart';

enum Importance { low, basic, high }

class TaskModel {
  final String id;
  final String text;
  final Importance importance;
  final DateTime deadline;
  final bool done;
  final Color color;
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
}
