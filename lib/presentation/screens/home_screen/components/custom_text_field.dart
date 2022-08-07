import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

class CustomTextField extends StatelessWidget {
  final ScrollController scrollController;
  final TextEditingController textController;

  const CustomTextField({
    Key? key,
    required this.scrollController,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
        controller: textController,
        decoration: InputDecoration(
          // TODO: Localization
          hintText: L.of(context).newDeal,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 52, vertical: 14),
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
        ),
      );
}
