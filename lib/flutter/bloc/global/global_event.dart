part of 'global_bloc.dart';

@immutable
abstract class GlobalEvent {}

class TestBloc extends GlobalEvent {
  TestBloc();
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

class AuthTokenUser extends GlobalEvent {
  final String token;
  AuthTokenUser(
    this.token,
  );
}

class GetFullUser extends GlobalEvent {
  final String? id;
  final String? token;
  GetFullUser({
    required this.id,
    required this.token,
  });
}

class GetAddresses extends GlobalEvent {
  final String? name;
  final String? userId;
  final String? token;
  GetAddresses({
    required this.name,
    required this.userId,
    required this.token,
  });
}

class DeleteAddress extends GlobalEvent {
  final String? addressId;
  final String? userId;
  final String? token;
  DeleteAddress({
    required this.addressId,
    required this.userId,
    required this.token,
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
