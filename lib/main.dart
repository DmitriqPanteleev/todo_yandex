import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/repositories/network_repository.dart';
import 'package:todo_list/internationalization/lang.dart';
import 'package:todo_list/logging/error_hadler.dart';
import 'package:todo_list/logging/logger.dart';
import 'package:todo_list/navigation/controller.dart';
import 'package:todo_list/navigation/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list/presentation/app_theme/app_theme.dart';
import 'package:todo_list/presentation/bloc/edit/edit_cubit.dart';
import 'package:todo_list/presentation/bloc/home/home_cubit.dart';

void main() {
  runZonedGuarded(() {
    initLogger();
    logger.info('Start main');

    ErrorHandler.init();
    runApp(const Application());
  }, ErrorHandler.recordError);
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    final routeObserver = RouteObserver();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: Provider<RouteObserver>.value(
        value: routeObserver,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (_) => HomeCubit(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme(),
            // Localization settings
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L.supportedLocales,
            locale: L.ru,

            // Routing settings
            initialRoute: Routes.homeScreen,
            onGenerateRoute: ((settings) =>
                navigationController.onGenerateRoute(settings)),
            navigatorKey: navigationController.key,
          ),
        ),
      ),
    );
  }
}
