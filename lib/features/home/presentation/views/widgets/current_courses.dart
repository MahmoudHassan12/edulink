import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/professor_entity.dart';
import 'package:edu_link/features/home/presentation/views/widgets/course.dart';
import 'package:flutter/material.dart';

class CurrentCourses extends StatelessWidget {
  const CurrentCourses({super.key});
  @override
  Widget build(BuildContext context) {
    const i = 4 / 3;
    return AspectRatio(
      aspectRatio: i,
      child: CarouselView(
        itemExtent: MediaQuery.sizeOf(context).width / i,
        itemSnapping: true,
        children: _courses.map((course) => Course(course: course)).toList(),
      ),
    );
  }
}

const List<CourseEntity> _courses = [
  CourseEntity(
    code: 'Stat 303',
    title: 'Stochastic Processes',
    imageUrl:
        'https://miro.medium.com/v2/resize:fit:1100/format:webp/1*Y6-ksYxoEqnqZHChb4VDxg.png',
    professor: ProfessorEntity(
      name: 'Dr. John Doe',
      imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    ),
  ),
  CourseEntity(
    code: 'Comp 404',
    title: 'Advanced Algorithms',
    imageUrl:
        'https://miro.medium.com/v2/resize:fit:3840/format:webp/1*g76wIu8hNQVJ2OGBzZ42rQ.jpeg',
    professor: ProfessorEntity(
      name: 'Dr. Jane Doe',
      imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    ),
  ),
  CourseEntity(
    code: 'MATH 101',
    title: 'Calculus I',
    imageUrl:
        'https://orientation.engsci.utoronto.ca/wp-content/uploads/2021/06/calculus_image-2.png',
    professor: ProfessorEntity(
      name: 'Dr. Jack Doe',
      imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    ),
  ),
  CourseEntity(
    code: 'MATH 102',
    title: 'Calculus II',
    imageUrl:
        'https://ximera.osu.edu/mooculus/logos/calculus2Logo/logo.png',
    professor: ProfessorEntity(
      name: 'Dr. Jill Doe',
      imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
    ),
  ),
];
