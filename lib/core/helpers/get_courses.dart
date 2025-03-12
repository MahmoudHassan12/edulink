import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;

List<CourseEntity>? getCourses() {
  final courses = SharedPrefSingleton.getStringList(Endpoints.courses);
  if (courses?.isNotEmpty ?? false) {
    return SharedPrefSingleton.getStringList(
      Endpoints.courses,
    )?.map((e) => CourseEntity.fromMap(jsonDecode(e))).toList();
  }
  return null;
}

Future<bool?> getCoursesMethod() async {
  try {
    final docSnapshot =
        await FirebaseFirestore.instance
            .collection('courses')
            // .doc(currentUser.uid)
            .get();

    // if (!docSnapshot.exists) {
    //   log('Error: User document does not exist for ID: ${currentUser.uid}');
    //   return null;
    // }

    final data = docSnapshot.docs;
    // if (data == null) {
    //   log('Error: User data is null');
    //   return null;
    // }

    // log('Fetched User Data: $data');

    // Parse the courses if they exist
    // final coursesData = data['courses'] as List<dynamic>? ?? [];
    // log('Courses Raw Data: $coursesData');

    // final courses =
    //     coursesData
    //         .map(
    //           (course) => CourseEntity.fromMap(course as Map<String, dynamic>?),
    //         )
    //         .toList();
    // await SharedPrefSingleton.setStringList(
    //   Endpoints.courses,
    //   courses.map((course) => jsonEncode(course.toMap())).toList(),
    // );
    // final coursesMap = data[0].data();
    final coursesList =
        data.map((doc) => CourseEntity.fromMap(doc.data()).toMap()).toList();
    return SharedPrefSingleton.setStringList(
      Endpoints.courses,
      coursesList.map((course) => jsonEncode(course)).toList(),
    );
  } catch (e) {
    log('Error while fetching user data: $e');
    return null;
  }
}
