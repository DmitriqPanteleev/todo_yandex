import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/internationalization/lang.dart';
import 'package:todo_list/navigation/controller.dart';

import 'package:todo_list/presentation/bloc/edit/edit_cubit.dart';
import 'package:todo_list/presentation/bloc/home/home_cubit.dart';
import 'package:todo_list/presentation/screens/edit_screen/components/custom_drop_down.dart';
import 'package:todo_list/presentation/screens/edit_screen/components/custom_text_field.dart';
import 'package:todo_list/presentation/screens/edit_screen/components/delete_button.dart';
import 'package:todo_list/presentation/screens/edit_screen/components/simple_app_bar.dart';
import 'package:todo_list/domain/models/task_model.dart';

class EditScreen extends StatefulWidget {
  final TaskModel? task;

  const EditScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _textFieldController = TextEditingController();

  // будет ли таска вообще иметь дедлайн
  late bool hasDeadline;

  late final EditCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = EditCubit(task: widget.task ?? TaskModel.empty());
    hasDeadline = false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021, 12),
        lastDate: DateTime(2031, 12));

    if (picked != null) {
      setState(() {
        // deadline = picked;
      });
    } else {
      setState(() {
        hasDeadline = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocConsumer<EditCubit, EditState>(
          listener: (context, state) {
            if (state is EditSuccess) {
              NavigationController()
                  .navigateToHomeScreen()
                  .then((_) => BlocProvider.of<HomeCubit>(context).getTasks());
            }
          }, // TODO: error state
          bloc: _cubit,
          builder: (context, state) {
            if (state is EditInitial) {
              return CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  const SliverPersistentHeader(
                    delegate: SimpleAppBar(height: 96.0),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            text: widget.task.text,
                            controller: _textFieldController,
                          ),
                          const SizedBox(height: 28),
                          const CustomDropDownButton(),
                          const Divider(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(L.of(context).doBefore),
                                  if (hasDeadline)
                                    Text(
                                        "${state.task.deadline?.day}.${state.task.deadline?.month}.${state.task.deadline?.year}"),
                                ],
                              ),
                              Switch(
                                  value: hasDeadline,
                                  onChanged: (value) {
                                    setState(() {
                                      hasDeadline = value;
                                    });
                                    if (hasDeadline) {
                                      _selectDate(context);
                                    }
                                  }),
                            ],
                          ),
                          const Divider(
                            height: 50,
                          ),
                          DeleteButton(
                            onPressed: () {}, // TODO: onPressed
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('Ooops... Something went wrong'));
          },
        ),
      );
}
