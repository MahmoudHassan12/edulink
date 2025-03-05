import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart';

Future<UserEntity?> getUser() async {
  final currentUser = AuthService().currentUser;
  if (currentUser == null) {
    log('Error: No current user found');
    return null;
  }

  try {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

    if (!docSnapshot.exists) {
      log('Error: User document does not exist for ID: ${currentUser.uid}');
      return null;
    }

    final data = docSnapshot.data();
    if (data == null) {
      log('Error: User data is null');
      return null;
    }

    log('Fetched User Data: $data');

    // Parse the courses if they exist
    final coursesData = data['courses'] as List<dynamic>? ?? [];
    log('Courses Raw Data: $coursesData');

    final courses =
        coursesData
            .map(
              (course) => CourseEntity.fromMap(course as Map<String, dynamic>?),
            )
            .toList();
    return UserEntity.fromMap(data, courses: courses);
  } catch (e) {
    log('Error while fetching user data: $e');
    return null;
  }
}
