part of 'global_bloc.dart';

class GlobalState {
  final String test;
  GlobalState({
    this.test = 'test',
  });

  GlobalState copyWith({
    String? test,
  }) {
    return GlobalState(
      test: test ?? this.test,
    );
  }
}
