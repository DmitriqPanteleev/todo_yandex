import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  String? text;

  CustomTextField({
    Key? key,
    required this.controller,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: const Offset(0, 2),
                blurRadius: 2.0),
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: const Offset(0, 0),
                blurRadius: 2.0)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          minLines: 4,
          maxLines: null,
          controller: text != null
              ? TextEditingController.fromValue(TextEditingValue(text: text!))
              : controller,
          enabled: true,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(16),
              hintText: L.of(context).doSomething),
          onChanged: ((value) => {}),
        ),
      );
}

// OutlineInputBorder(
//               borderSide: BorderSide(width: 0.0),
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),