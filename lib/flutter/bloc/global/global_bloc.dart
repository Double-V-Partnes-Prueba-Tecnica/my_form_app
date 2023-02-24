import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_form_app/services/api/app_api_service.dart';
import 'package:my_form_app/services/storage/app_storage.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<TestBloc>((event, emit) {
      debugPrint('TestBloc ${DateTime.now()}');
      _testBloc();
    });

    on<AuthBloc>((event, emit) {
      debugPrint('AuthBloc ${DateTime.now()}');
      _authBloc();
    });

    on<SignOut>((event, emit) {
      debugPrint('SignOut ${DateTime.now()}');
      AppStorage.deleteProperty('token');
      emit(state.copyWith(isLoggedIn: false));
    });

    on<RegisterUser>((event, emit) async {
      debugPrint('RegisterUser ${DateTime.now()}');
      String body = jsonEncode({
        'username': event.username,
        'password': event.password,
        'name': event.name,
        'lastname': event.lastName,
        'birthdate': event.birthDate.toIso8601String(),
      });
      debugPrint('body: $body');
      dynamic data;

      try {
        debugPrint('registering user');
        final ApiResponse response = await AppApiService.postHttp(
          'users',
          body,
        );
        debugPrint('response body: ${response.data}');
        data = jsonDecode(response.data);
      } catch (e) {
        debugPrint('error: $e');
      }

      debugPrint('data: $data');
      // si existe el id
      if (data['id'] != null) {
        debugPrint('ENCONTRADO ID');
        // agregar password al usuario
        data['password'] = event.password;
        // Setea usuario en el state
        add(SetUser(data));
        debugPrint('user: ${state.user}');
      } else {
        // No se pudo registrar el usuario
        add(SetUser(null));
      }
      add(SetIsLoading(false));
    });

    on<LoginUser>((event, emit) async {
      debugPrint('LoginUser ${DateTime.now()}');
      String body = jsonEncode({
        'username': event.username,
        'password': event.password,
      });
      debugPrint('body: $body');
      dynamic data;

      try {
        debugPrint('logging user');
        final ApiResponse response = await AppApiService.postHttp(
          'login',
          body,
        );
        debugPrint('response body: ${response.data}');
        data = jsonDecode(response.data);
      } catch (e) {
        debugPrint('error: $e');
      }

      debugPrint('data: $data');
      // si existe el token
      if (data['token'] != null) {
        debugPrint('ENCONTRADO TOKEN');
        // Setea token en el storage
        await AppStorage.setProperty('token', data['token']);
        // Setea usuario en el state
        add(SetUser(data['user']));
        add(SetIsLoggedIn(true));
        debugPrint('user: ${state.user}');
      } else {
        // No se pudo loguear el usuario
        add(SetUser(null));
      }
      add(SetIsLoading(false));
    });

    // SETTERS
    on<SetIsLoggedIn>((event, emit) {
      debugPrint('SetIsLoggedIn ${DateTime.now()}');
      emit(state.copyWith(isLoggedIn: event.isLoggedIn));
    });

    on<SetUser>((event, emit) {
      debugPrint('SetUser ${DateTime.now()}');
      emit(state.copyWith(user: event.user));
    });

    on<SetIsLoading>((event, emit) {
      debugPrint('SetIsLoading ${DateTime.now()}');
      emit(state.copyWith(isLoading: event.isLoading));
    });
  }
  _testBloc() async {
    final ApiResponse response = await AppApiService.getHttp('ping');
    debugPrint('response body: ${response.data}');
  }

  _authBloc() async {
    final String? token = await AppStorage.getProperty('token');
    debugPrint('token: $token');
    if (token != null) {
      add(SetIsLoggedIn(true));
    } else {
      add(SetIsLoggedIn(false));
    }
  }
}
