import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

class DeleteButton extends StatefulWidget {
  final void Function()? onPressed;
  const DeleteButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onPressed,
        child: SizedBox(
          width: double.infinity,
          height: 24.0,
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              const SizedBox(width: 17),
              Text(
                L.of(context).delete,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      );
}
