import 'dart:async';

import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

part 'registered_users_state.dart';

class RegisteredUsersCubit extends Cubit<RegisteredUsersState> {
  RegisteredUsersCubit(this.courseId) : super(RegisteredUsersInitial()) {
    streamUsersByCourse();
  }
  final String courseId;

  late StreamSubscription<List<UserEntity>?> _subscription;
  StreamSubscription<List<UserEntity>?> streamUsersByCourse() {
    emit(RegisteredUsersLoading());
    return _subscription = const UserRepo()
        .streamUsersByCourse(courseId)
        .listen(
          (users) => emit(RegisteredUsersSuccess(users)),
          onError: (error) => emit(RegisteredUsersFailure(error.toString())),
        );
  }

  @override
  Future<void> close() {
    unawaited(_subscription.cancel());
    return super.close();
  }
}
