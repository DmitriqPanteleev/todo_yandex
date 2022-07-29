import 'package:todo_list/domain/models/task_model.dart';

extension ImportanceConverter on Importance {
  String toJSON() {
    String? result;
    switch (this) {
      case Importance.low:
        result = 'low';
        break;
      case Importance.basic:
        result = 'basic';
        break;
      case Importance.high:
        result = 'high';
        break;
    }
    return result;
  }

  static Importance fromJSON(String data) {
    Importance? result;
    switch (data) {
      case 'low':
        result = Importance.low;
        break;
      case 'basic':
        result = Importance.basic;
        break;
      case 'high':
        result = Importance.high;
        break;
    }
    return result!;
  }
}
