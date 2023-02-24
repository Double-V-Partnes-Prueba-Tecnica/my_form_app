part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

class TestBloc extends GlobalEvent {
  TestBloc();
}

class AuthBloc extends GlobalEvent {
  final BuildContext context;
  AuthBloc({required this.context});
}

class SignOut extends GlobalEvent {
  SignOut();
}

class RegisterUser extends GlobalEvent {
  final BuildContext context;
  final String username;
  final String password;
  final String name;
  final String lastName;
  final DateTime birthDate;
  RegisterUser({
    required this.context,
    required this.username,
    required this.password,
    required this.name,
    required this.lastName,
    required this.birthDate,
  });
}

class LoginUser extends GlobalEvent {
  final BuildContext context;
  final String username;
  final String password;
  LoginUser({
    required this.context,
    required this.username,
    required this.password,
  });
}

// SETTERS
class SetIsLoggedIn extends GlobalEvent {
  final bool isLoggedIn;
  SetIsLoggedIn(this.isLoggedIn);
}

class SetUser extends GlobalEvent {
  final dynamic user;
  SetUser(this.user);
}

class SetIsLoading extends GlobalEvent {
  final bool isLoading;
  SetIsLoading(this.isLoading);
}
