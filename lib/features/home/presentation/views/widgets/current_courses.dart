import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';

class CurrentCourses extends StatelessWidget {
  CurrentCourses({super.key});

  final Stream<QuerySnapshot> snapshots =
      FirebaseFirestore.instance
          .collection("users")
          .doc("bRZb8DyWp8chlGHIXa1iMMqxynq2")
          .collection("courses")
          .snapshots();

  @override
  Widget build(BuildContext context) {
    const aspectRatio = 4 / 3;

    return StreamBuilder<QuerySnapshot>(
      stream: snapshots,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: EText("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: EText("No courses available"));
        }

        // Convert Firestore documents into CourseEntity objects
        List<CourseEntity> courses =
            snapshot.data!.docs.map((doc) {
              return CourseEntity.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();

        return AspectRatio(
          aspectRatio: aspectRatio,
          child: CarouselView(
            itemExtent: MediaQuery.sizeOf(context).width / aspectRatio,
            itemSnapping: true,
            children:
                courses.map((course) {
                  return Course(course: course);
                }).toList(),
          ),
        );
      },
    );
  }
}
