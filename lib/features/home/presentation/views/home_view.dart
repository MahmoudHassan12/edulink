import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/duration_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/auth_service.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart';
import 'package:edu_link/features/home/presentation/views/widgets/app_drawer.dart';
import 'package:edu_link/features/home/presentation/views/widgets/e_navigation_bar.dart';
import 'package:edu_link/features/home/presentation/views/widgets/home_view_body.dart'
    show HomeViewBody;
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: const HomeViewBody(),
    floatingActionButton:
        (getUser()?.isProfessor ?? false)
            ? const AddCourseFloatingButton()
            : null,
    drawer: const AppDrawer(),
    bottomNavigationBar: const ENavigationBar(),
  );
}

class AddCourseFloatingButton extends StatelessWidget {
  const AddCourseFloatingButton({super.key});
  @override
  Widget build(BuildContext context) => FloatingActionButton(
    onPressed: () async => manageCourseNavigation(context),
    // () async => _addToFirestore(),
    child: const Icon(Icons.add_rounded),
  );
}

// ignore: unused_element
Future<void> _addToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final currentUser = AuthService().currentUser;
  const user = UserEntity(
    id: '1234',
    name: 'Mahmoud Hassan',
    email: 'mahmoud@example.com',
    phone: '+201234567890',
    imageUrl: 'https://avatar.iran.liara.run/public/18',
    department: 'Computer Science',
    level: 'Senior',
    program: 'Stat & CS',
    ssn: '987654321',
    academicTitle: 'Student',
    courses: [
      CourseEntity(
        id: 'C1',
        code: 'CS101',
        title: 'Introduction to Computer Science',
        description: 'Basic computer science concepts',
        imageUrl:
            'https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fx8igqsckpqq7cqu5le9q.jpeg',
        type: 'Core',
        level: 'Beginner',
        department: 'CS',
        semester: '1',
        creditHour: 3,
        lectures: 30,
        duration: DurationEntity(hours: 1, minutes: 30),
        professor: UserEntity(
          name: 'Dr. John',
          imageUrl: 'https://avatar.iran.liara.run/public/32',
        ),
      ),
      CourseEntity(
        id: 'C2',
        code: 'CS102',
        title: 'Data Structures',
        description: 'Learn about various data structures',
        imageUrl:
            'https://oaustech.edu.ng/media/k2/items/cache/5288462d048e0d3f60f64bb84cff6df4_M.jpg',
        type: 'Core',
        level: 'Intermediate',
        department: 'CS',
        semester: '2',
        creditHour: 4,
        lectures: 40,
        duration: DurationEntity(hours: 2),
        professor: UserEntity(
          name: 'Dr. Sarah',
          imageUrl: 'https://avatar.iran.liara.run/public/66',
        ),
      ),
      CourseEntity(
        id: 'C3',
        code: 'CS201',
        title: 'Algorithms',
        description: 'Deep dive into algorithms and their complexities',
        imageUrl:
            'https://www.bolton.ac.uk//assets/Uploads/Why-you-dont-have-to-be-a-genius-to-do-computer-science-University-of-Bolton.jpg',
        type: 'Elective',
        level: 'Advanced',
        department: 'CS',
        semester: '3',
        creditHour: 3,
        lectures: 35,
        duration: DurationEntity(hours: 1, minutes: 45),
        professor: UserEntity(
          name: 'Dr. Ahmed',
          imageUrl: 'https://avatar.iran.liara.run/public/40',
        ),
      ),
      CourseEntity(
        id: 'C4',
        code: 'CS301',
        title: 'Operating Systems',
        description: 'Understand how operating systems work',
        imageUrl:
            'https://static.wixstatic.com/media/0c0246_7f184faf1ab149d98a3afd56fe33c0aa~mv2.jpg/v1/fill/w_386,h_289,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/cse%202.jpg',
        type: 'Core',
        level: 'Advanced',
        department: 'CS',
        semester: '4',
        creditHour: 4,
        lectures: 45,
        duration: DurationEntity(hours: 2, minutes: 15),
        professor: UserEntity(
          name: 'Dr. Emily',
          imageUrl: 'https://avatar.iran.liara.run/public/67',
        ),
      ),
      CourseEntity(
        id: 'C5',
        code: 'CS401',
        title: 'Database Management Systems',
        description: 'Learn how to manage and design databases',
        imageUrl:
            'https://static.wixstatic.com/media/0c0246_8a9e99ebe7ee4c458782203abcc47694~mv2.jpg/v1/fill/w_374,h_289,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/0c0246_8a9e99ebe7ee4c458782203abcc47694~mv2.jpg',
        type: 'Core',
        level: 'Advanced',
        department: 'CS',
        semester: '5',
        creditHour: 3,
        lectures: 50,
        duration: DurationEntity(hours: 1, minutes: 50),
        professor: UserEntity(
          name: 'Dr. Michael',
          imageUrl: 'https://avatar.iran.liara.run/public/34',
        ),
      ),
    ],
    office: OfficeEntity(
      location: LocationEntity(
        building: 'Main Building',
        floor: '2nd Floor',
        department: 'Computer Science',
        room: '205',
      ),
      availability: AvailabilityEntity(
        times: [
          AvailableTimeEntity(
            day: 'Monday',
            from: TimeOfDay(hour: 9, minute: 0),
            to: TimeOfDay(hour: 12, minute: 0),
          ),
          AvailableTimeEntity(
            day: 'Wednesday',
            from: TimeOfDay(hour: 13, minute: 0),
            to: TimeOfDay(hour: 15, minute: 0),
          ),
        ],
      ),
      contactInfo: 'contact@example.com',
    ),
  );

  try {
    await firestore.collection('users').doc(currentUser?.uid).set(user.toMap());
    log('User added successfully!');
  } catch (e) {
    log('Failed to add user: $e');
  }
}
