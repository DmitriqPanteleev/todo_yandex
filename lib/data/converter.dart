import 'package:flutter/material.dart';

import 'package:todo_list/domain/models/task.dart';

extension ColorConverter on Color {
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ImportanceConverter on Importance {
  String toJSON() {
    String? result;
    switch (this) {
      case Importance.low:
        result = "low";
        break;
      case Importance.basic:
        result = "basic";
        break;
      case Importance.high:
        result = "high";
        break;
    }
    return result;
  }

  static Importance fromJSON(String data) {
    Importance? result;
    switch (data) {
      case "low":
        result = Importance.low;
        break;
      case "basic":
        result = Importance.basic;
        break;
      case "high":
        result = Importance.high;
        break;
    }
    return result!;
  }
}

extension TaskConverter on Task {
  Map<String, dynamic> toJSON() => {
        "status": "ok",
        "element": {
          "id": id,
          "text": text,
          "importance": importance.toJSON(),
          "deadline": deadline,
          "done": done,
          "color": color.toHex(),
          "created_at": createdAt.toUtc().millisecondsSinceEpoch,
          "changed_at": changedAt.toUtc().millisecondsSinceEpoch,
          "last_updated_by": lastUpdatedBy,
        }
      };

  static Task fromJSON(Map<String, dynamic> data) => Task(
        id: data["element"]["id"] as String,
        text: data["element"]["text"] as String,
        importance: ImportanceConverter.fromJSON(
            data["element"]["importance"] as String),
        deadline: DateTime.fromMillisecondsSinceEpoch(
            (data["element"]["deadline"]) * 1000),
        done: data["element"]["done"] as bool,
        color: ColorConverter.fromHex(data["element"]["color"] as String),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (data["element"]["created_at"] as int) * 1000),
        changedAt: DateTime.fromMillisecondsSinceEpoch(
            (data["element"]["changedAt"] as int) * 1000),
        lastUpdatedBy: data["element"]["last_updated_by"],
      );
}
