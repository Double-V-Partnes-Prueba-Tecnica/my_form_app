part of 'global_bloc.dart';

class GlobalState {
  final String test;
  final bool isLoggedIn;
  final dynamic user;
  final bool isLoading;
  GlobalState({
    this.test = 'test',
    this.isLoggedIn = false,
    this.user,
    this.isLoading = false,
  });

  GlobalState copyWith({
    String? test,
    bool? isLoggedIn,
    dynamic user,
    bool? isLoading,
  }) {
    return GlobalState(
      test: test ?? this.test,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
