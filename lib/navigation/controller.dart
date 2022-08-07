import 'package:flutter/material.dart';
import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/navigation/routes.dart';
import 'package:todo_list/presentation/screens/edit_screen/edit_screen.dart';
import 'package:todo_list/presentation/screens/home_screen/home_screen.dart';

class NavigationController {
  NavigationController._internal();
  static final NavigationController _ = NavigationController._internal();
  factory NavigationController() => _;

  final GlobalKey<NavigatorState> _key = GlobalKey();

  GlobalKey<NavigatorState> get key => _key;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.editScreen:
        return MaterialPageRoute(
            builder: (_) => EditScreen(task: settings.arguments as TaskModel));
      default:
        throw Exception('an unknown route name');
    }
  }

  Future<void> navigateToEditScreen({required TaskModel arguments}) async {
    _key.currentState?.pushNamed(Routes.editScreen, arguments: arguments);
  }

  Future<void> navigateToHomeScreen({Object? arguments}) async {
    _key.currentState?.pushNamed(Routes.homeScreen, arguments: arguments);
  }

  void pop([Object? result]) {
    _key.currentState?.pop(result);
  }

  Future<T> pushDialog<T>(RawDialogRoute<T> route) async {
    return _key.currentState?.push<T>(route) as Future<T>;
  }
}
