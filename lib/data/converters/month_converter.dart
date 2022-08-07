import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

// TODO: дописать до конца

extension MonthConverter on DateTime {
  String? monthToString(BuildContext context) {
    String? result;
    switch (month) {
      case 1:
        result = L.of(context).jan;
        break;
      case 2:
        result = L.of(context).feb;
        break;
      case 3:
        result = L.of(context).mar;
        break;
      case 4:
        result = L.of(context).apr;
        break;
      case 5:
        result = L.of(context).may;
        break;
      case 6:
        result = L.of(context).jun;
        break;
      case 7:
        result = L.of(context).jul;
        break;
      case 8:
        result = L.of(context).aug;
        break;
      case 9:
        result = L.of(context).sep;
        break;
      case 10:
        result = L.of(context).oct;
        break;
      case 11:
        result = L.of(context).nov;
        break;
      case 12:
        result = L.of(context).dec;
        break;
    }
    return result;
  }
}
