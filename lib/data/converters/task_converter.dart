import 'package:todo_list/data/converters/importance_converter.dart';

import '../../domain/models/task_model.dart';
import 'color_converter.dart';

extension TaskConverter on TaskModel {
  Map<String, dynamic> toJSON() => <String, dynamic>{
        'status': 'ok',
        'element': <String, dynamic>{
          'id': id,
          'text': text,
          'importance': importance.toJSON(),
          'deadline': deadline?.toUtc().millisecondsSinceEpoch,
          'done': done,
          'color': color?.toHex(),
          'created_at': createdAt.toUtc().millisecondsSinceEpoch,
          'changed_at': changedAt.toUtc().millisecondsSinceEpoch,
          'last_updated_by': lastUpdatedBy,
        }
      };

  static TaskModel fromJSON(Map<String, dynamic> data) => TaskModel(
        id: data['id'] as String,
        text: data['text'] as String,
        importance: ImportanceConverter.fromJSON(data['importance'] as String),
        deadline: data['deadline'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch((data['deadline'] as int)),
        done: data['done'] as bool,
        color: ColorConverter.fromHex(data['color'] as String),
        createdAt:
            DateTime.fromMillisecondsSinceEpoch((data['created_at'] as int)),
        changedAt:
            DateTime.fromMillisecondsSinceEpoch((data['changed_at'] as int)),
        lastUpdatedBy: data['last_updated_by'] as String,
      );
}
