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
    await AppStorage.setProperty('test', 'test');
    debugPrint('test ${await AppStorage.getProperty('test')}');
    await AppStorage.deleteProperty('test');
  }
}
