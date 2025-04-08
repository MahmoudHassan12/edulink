import 'dart:convert' show jsonEncode;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/user_repo.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    _getStreamData();
  }
  void _getStreamData() {
    emit(const HomeLoading());
    try {
      const UserRepo().getStream(documentId: getUser!.id!).listen((user) async {
        emit(const HomeLoading());
        await SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(user?.toMap(toSharedPref: true)),
        );
        emit(const HomeSuccess());
      });
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
