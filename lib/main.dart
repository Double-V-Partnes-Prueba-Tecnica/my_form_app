import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/services/router/app_routes.dart';
import 'package:my_form_app/services/storage/app_storage.dart';
import 'package:my_form_app/services/theme/app_theme.dart';
import 'flutter/bloc/global/global_bloc.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
          create: (_) => GlobalBloc(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
    globalBloc.add(TestBloc());
    return MaterialApp(
      title: 'My Form App',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.getAppRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
