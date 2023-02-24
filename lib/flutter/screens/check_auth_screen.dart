import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/flutter/bloc/global/global_bloc.dart';
import 'package:my_form_app/flutter/screens/screens.dart';
import 'package:my_form_app/services/storage/app_storage.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AppStorage.getProperty('token'),
        builder: (context, snapshot) {
          final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              globalBloc.add(SetIsLoading(true));
              globalBloc.add(AuthTokenUser(snapshot.data ?? ''));
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });

              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Future.microtask(() {
                globalBloc.add(SetIsLoading(true));
                globalBloc.add(SignOut());
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }
}
