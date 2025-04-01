import 'dart:async';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    unawaited(getInitialData());
  }

  Future<void> getInitialData() async {
    emit(const HomeLoading());
    try {
      final userStream = const UserRepo().getStream(documentId: getUser!.id!);
      await for (final _ in userStream) {
        emit(HomeSuccess());
      }
    } catch (error) {
      emit(HomeFailure(error.toString()));
    }
  }
}
