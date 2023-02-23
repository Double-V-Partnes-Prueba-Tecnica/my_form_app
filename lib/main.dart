import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/services/router/app_routes.dart';
import 'flutter/bloc/global/global_bloc.dart';

void main() {
  runApp(const MyApp());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
          create: (context) => GlobalBloc(),
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
    return MaterialApp(
      title: 'My Form App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: AppRoutes.getAppRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
