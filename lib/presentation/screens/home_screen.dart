import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/presentation/bloc/home/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit cubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: cubit,
        listener: (previosState, currentState) {
          if (currentState is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(currentState.message),
              ),
            );
            if (currentState is HomeInitial) {
              cubit.getTasks();
            }
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeLoaded) {
            final tasks = state.tasks;

            return SafeArea(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tasks[index].text),
                      );
                    }));
          }
          return const Center(child: Text("Ooops..."));
        },
      ),
    );
  }
}
