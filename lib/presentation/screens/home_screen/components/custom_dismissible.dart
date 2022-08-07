import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/presentation/bloc/home/home_cubit.dart';

import '../../../../domain/models/task_model.dart';

class CustomDismissible extends StatelessWidget {
  final int index;
  final Widget cellWidget;
  final List<TaskModel> tasks;

  const CustomDismissible({
    Key? key,
    required this.tasks,
    required this.index,
    required this.cellWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: Key(tasks[index].toString()),
        background: Container(
          alignment: Alignment.centerLeft,
          color: Colors.green,
          padding: const EdgeInsets.only(left: 27),
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          padding: const EdgeInsets.only(right: 27),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          switch (direction) {
            case DismissDirection.startToEnd:
              cubit.editTask(tasks[index].copyWith(done: true));
              break;
            case DismissDirection.endToStart:
              cubit.removeTask(tasks[index].id);
              break;
            default:
              return;
          }
        },
        child: cellWidget,
      );
}
