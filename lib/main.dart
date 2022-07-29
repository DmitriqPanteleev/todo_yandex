import 'package:flutter/material.dart';
import 'package:todo_list/presentation/screens/home_screen.dart';

void main() async => runApp(const Application());

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomeScreen());
}
