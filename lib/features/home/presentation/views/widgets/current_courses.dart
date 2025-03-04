import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});
  @override
  Widget build(BuildContext context) {
    final currentUserUID = AuthService().currentUser?.uid;
    if (currentUserUID == null) {
      return const Center(child: EText('User not logged in'));
    }
    final Stream<QuerySnapshot> snapshots =
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserUID)
            .collection('courses')
            .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: snapshots,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: EText('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? true)) {
          return AspectRatio(
            aspectRatio: 4 / 3,
            child: CarouselView(
              itemExtent: MediaQuery.sizeOf(context).width - 80,
              itemSnapping: true,
              enableSplash: false,
              children:
                  getUser().courses!
                      .map((course) => Course(course: course))
                      .toList(),
            ),
          );
          // return const Center(child: EText('No courses available'));
        }
        final courses =
            snapshot.data?.docs
                .map(
                  (doc) =>
                      CourseEntity.fromMap(doc.data() as Map<String, dynamic>?),
                )
                .toList();
        return AspectRatio(
          aspectRatio: 4 / 3,
          child: CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width - 80,
            itemSnapping: true,
            enableSplash: false,
            children: courses!.map((course) => Course(course: course)).toList(),
          ),
        );
      },
    );
  }
}
