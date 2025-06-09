import 'dart:developer' show log;

import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, BlocBase, BlocObserver, Change, Transition;

class BlocObserve extends BlocObserver {
  const BlocObserve();
  void init() => Bloc.observer = this;
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    log('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('${bloc.runtimeType} closed');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log('${bloc.runtimeType} created');
    super.onCreate(bloc);
  }
}
