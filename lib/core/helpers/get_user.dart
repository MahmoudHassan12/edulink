import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/repos/user_repo.dart';

UserEntity? get getUser => const UserRepo().getFromLocal();
