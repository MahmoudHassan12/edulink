import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;

// TODO(Mahmoud): Get user from shared preferences or database
UserEntity getUser() => const UserEntity(
  id: '123456789',
  name: 'Hosam Hasan',
  email: '30123456789123@sci.asu.edu.eg',
  phone: '0123456789',
  imageUrl: 'https://avatar.iran.liara.run/public/49',
  department: 'Mathematics',
  level: 'Level 4',
  program: 'Statistics & CS',
  ssn: '123456',
  isProfessor: true,
);
