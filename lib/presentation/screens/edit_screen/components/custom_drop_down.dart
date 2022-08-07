import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({Key? key}) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L.of(context).imortance),
              DropdownButton<String>(
                hint: Text(L.of(context).no),
                items: <String>[
                  L.of(context).no,
                  L.of(context).low,
                  "!! ${L.of(context).high}"
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  // TODO: !!!
                  // switch (value) {
                  //   case "low":

                  //   case "basic":

                  //   case "high":

                  // }
                },
              ),
            ],
          ),
          const Spacer(),
        ],
      );
}


// items: <Importance>[Importance.low, Importance.basic, Importance.high]
//             .map((Importance value) {
//           return DropdownMenuItem<Importance>(
//             value: value,
//             child: Text(value.toString()),
//           );
//         }).toList(),