import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_form_app/services/storage/app_storage.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<TestBloc>((event, emit) {
      debugPrint('TestBloc ${DateTime.now()}');
      _testBloc();
    });
  }
  _testBloc() async {
    debugPrint(await AppStorage.getProperty('test'));
    await AppStorage.setProperty('test', 'Ivan Rene Perez');
  }
}
