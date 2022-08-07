import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list/presentation/bloc/home/home_cubit.dart';
import 'package:todo_list/presentation/screens/home_screen/components/custom_dismissible.dart';

import '../../../../domain/models/task_model.dart';
import 'custom_text_field.dart';

class NoteList extends StatefulWidget {
  final ScrollController scrollController;
  final TextEditingController textController;
  final List<TaskModel> tasks;

  const NoteList({
    Key? key,
    required this.tasks,
    required this.scrollController,
    required this.textController,
  }) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 28.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            controller: widget.scrollController,
            shrinkWrap: true,
            itemCount: widget.tasks.length + 1,
            itemBuilder: (context, index) => index == widget.tasks.length
                ? CustomTextField(
                    scrollController: widget.scrollController,
                    textController: widget.textController,
                  )
                : ClipRRect(
                    // TODO: Add borderRadius to the first cell
                    //borderRadius: BorderRadius.circular(10),
                    child: CustomDismissible(
                      tasks: widget.tasks,
                      index: index,
                      cellWidget: Container(
                        width: 344,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.green,
                              value: widget.tasks[index].done,
                              onChanged: (value) =>
                                  BlocProvider.of<HomeCubit>(context).editTask(
                                      widget.tasks[index]
                                          .copyWith(done: value)),
                            ),
                            Text(
                              widget.tasks[index].text,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                height: 16.0 / 20.0,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.info_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      );
}
