import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/models/task_model.dart';

import 'package:todo_list/navigation/controller.dart';
import 'package:todo_list/presentation/bloc/home/home_cubit.dart';
import 'package:todo_list/presentation/screens/home_screen/components/custom_app_bar.dart';
import 'package:todo_list/presentation/screens/home_screen/components/note_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          bloc: BlocProvider.of<HomeCubit>(context),
          listener: (previosState, currentState) {
            if (currentState is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(currentState.message),
                ),
              );
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
              return CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: CustomAppBar(
                      doneCount: tasks.where((task) => task.done).length,
                      foldedHeight: 88.0,
                      expandedHeight: 164.0,
                    ),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: NoteList(
                      tasks: state.tasks,
                      scrollController: _scrollController,
                      textController: _textEditingController,
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text('Ooops... Something went wrong'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationController()
                .navigateToEditScreen(
                  arguments: TaskModel.empty()
                      .copyWith(text: _textEditingController.text),
                )
                .then(
                  (value) => BlocProvider.of<HomeCubit>(context).getTasks(),
                );
          },
          child: const Icon(Icons.add),
        ),
      );
}
