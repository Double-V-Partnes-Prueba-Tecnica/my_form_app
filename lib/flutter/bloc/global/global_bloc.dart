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

    on<SignOut>((event, emit) {
      debugPrint('SignOut ${DateTime.now()}');
      AppStorage.deleteProperty('token');
      emit(state.copyWith(isLoggedIn: false));
      add(SetIsLoading(false));
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
        final ApiResponse response = await AppApiService.postHttp(
          'users/login',
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
        // Setea usuario en el state
        add(SetIsLoggedIn(true));
        add(AuthTokenUser(data['token']));
        debugPrint('user: ${state.user}');
        await AppStorage.setProperty('token', data['token']);
      } else {
        // No se pudo loguear el usuario
        // add(SetUser(null));
        add(SetIsLoggedIn(false));
        await AppStorage.deleteProperty('token');
      }
      add(SetIsLoading(false));
    });

    on<AuthTokenUser>((event, emit) async {
      debugPrint('AuthTokenUser: ${event.token}');
      // Pedir el usuario users/me con bearer token peticion get
      // Si existe el usuario
      // Setea usuario en el state
      dynamic data;
      try {
        final ApiResponse response = await AppApiService.getHttp(
          'users/me',
          token: event.token,
        );
        debugPrint('response body: ${response.data}');
        data = jsonDecode(response.data);
      } catch (e) {
        debugPrint('error: $e');
      }

      debugPrint('data: $data');
      // si existe el token
      if (data['id'] != null) {
        // Setea token en el storage
        // Setea usuario en el state
        add(SetIsLoggedIn(true));
        await AppStorage.setProperty('token', event.token);
        add(GetFullUser(id: data['id'], token: event.token));
      } else {
        // No se pudo loguear el usuario
        // add(SetUser(null));
        add(SetIsLoggedIn(false));
        await AppStorage.deleteProperty('token');
      }
      add(SetIsLoading(false));
    });

    on<GetFullUser>((event, emit) async {
      // Imprimir todo el estado
      if (event.id != null && event.id != '') {
        debugPrint('GetFullUser ${DateTime.now()} con usuario: ${event.id}');
        // Pedir el usuario users/me con bearer token peticion get
        // Si existe el usuario
        // Setea usuario en el state
        dynamic data;
        dynamic filter = {
          'include': [
            {
              'relation': 'addresses',
              'scope': {
                'where': {
                  'deletedAt': {
                    'inq': [null],
                  }
                },
              }
            },
          ],
          'where': {'id': event.id},
        };
        try {
          debugPrint('filter: $filter');
          final ApiResponse response = await AppApiService.getHttp(
            'users',
            token: event.token,
            filter: filter,
          );
          debugPrint('response body: ${response.data}');
          data = jsonDecode(response.data);
        } catch (e) {
          debugPrint('error: $e');
        }
        debugPrint('data: $data');
        // si existe el usuario
        if (data[0] != null) {
          debugPrint('ENCONTRADO USUARIO');
          // Setea usuario en el state
          add(SetUser(data[0]));
        } else {
          // No se pudo encontrar el usuario
          // add(SetUser(null));
          debugPrint('Usuario no encontrado');
        }
      }
      add(SetIsLoading(false));
    });

    on<GetAddresses>((event, emit) async {
      debugPrint('AddAddress ${DateTime.now()}');
      String body = jsonEncode({
        'name': event.name,
        'userId': event.userId,
      });
      debugPrint('body: $body');
      dynamic data;

      try {
        final ApiResponse response = await AppApiService.postHttp(
          'addresses',
          body,
          token: event.token,
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
        // Setea usuario en el state
        add(GetFullUser(id: event.userId, token: event.token));
      } else {
        // No se pudo registrar el usuario
        // add(SetUser(null));
        debugPrint('No se pudo agregar la direccion');
      }
      add(SetIsLoading(false));
    });

    on<DeleteAddress>((event, emit) async {
      debugPrint('DeleteAddress ${DateTime.now()}');

      try {
        await AppApiService.deleteHttp(
          'addresses',
          event.addressId ?? '',
          token: event.token,
        );
      } catch (e) {
        debugPrint('error: $e');
      }

      add(GetFullUser(id: event.userId, token: event.token));
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
}
