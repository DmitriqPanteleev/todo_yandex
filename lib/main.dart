import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list/data/api.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/presentation/screens/home_screen.dart';

import 'presentation/bloc/home/home_cubit.dart';

void main() async {
  final date = DateTime.now();
  final task = Task(
    id: "5",
    text: "44444444444",
    importance: Importance.basic,
    done: false,
    color: Colors.white,
    createdAt: date,
    changedAt: date,
    lastUpdatedBy: "1",
  );

  //await API().authorize();
  // await API().addTask(task);
  // await API().removeTask("1");
  await API().getTasks();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
