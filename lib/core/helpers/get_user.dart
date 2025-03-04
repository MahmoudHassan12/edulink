import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/duration_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart'
    show
        AvailabilityEntity,
        AvailableTimeEntity,
        LocationEntity,
        OfficeEntity,
        UserEntity;
import 'package:flutter/material.dart';

// TODO(Mahmoud): Get user from shared preferences or database
UserEntity getUser() => UserEntity(
  id: '123456789',
  name: 'Hosam Hasan',
  email: '30123456789123@sci.asu.edu.eg',
  phone: '0123456789',
  imageUrl: 'https://avatar.iran.liara.run/public/49',
  department: 'Mathematics',
  level: 'Level 4',
  courses: getCourses(),
  program: 'Statistics & CS',
  ssn: '123456',
  isProfessor: true,
  academicTitle: 'Professor',
  office: const OfficeEntity(
    location: LocationEntity(
      building: 'Building B',
      floor: 'Floor 2',
      department: 'Mathematics',
      room: 'Room 9',
    ),
    availability: AvailabilityEntity(
      times: [
        AvailableTimeEntity(
          day: 'Monday',
          from: TimeOfDay(hour: 9, minute: 0),
          to: TimeOfDay(hour: 12, minute: 0),
        ),
        AvailableTimeEntity(
          day: 'Tuesday',
          from: TimeOfDay(hour: 14, minute: 0),
          to: TimeOfDay(hour: 17, minute: 0),
        ),
        AvailableTimeEntity(
          day: 'Wednesday',
          from: TimeOfDay(hour: 9, minute: 0),
          to: TimeOfDay(hour: 12, minute: 0),
        ),
      ],
    ),
  ),
);

List<CourseEntity> getCourses() => [
  const CourseEntity(
    id: '123456789',
    code: 'MA123',
    title: 'Mathematics',
    description: 'This is a course about math',
    imageUrl:
        'https://staging.herovired.com/wp-content/uploads/2023/05/8-Useful-Data-Mining-Applications-of-2023-1.webp',
    level: 'Level 4',
    department: 'Mathematics',
    semester: 'Spring 2023',
    creditHour: 3,
    lectures: 12,
    duration: DurationEntity(hours: 3, minutes: 30, seconds: 0),
    professor: UserEntity(
      id: '123456789',
      name: 'Hosam Hasan',
      email: '30123456789123@sci.asu.edu.eg',
      phone: '0123456789',
      imageUrl: 'https://avatar.iran.liara.run/public/49',
      department: 'Mathematics',
      level: 'Level 4',
      isProfessor: true,
      academicTitle: 'Professor',
    ),
  ),
  const CourseEntity(
    id: '123456789',
    code: 'MA123',
    title: 'Mathematics',
    description: 'This is a course about math',
    imageUrl:
        'https://cdn.analyticsvidhya.com/wp-content/uploads/2023/08/generative-ai-course-672ca52b9cf04.webp',
    level: 'Level 4',
    department: 'Mathematics',
    semester: 'Spring 2023',
    creditHour: 3,
    lectures: 12,
    duration: DurationEntity(hours: 3, minutes: 30, seconds: 0),
    professor: UserEntity(
      id: '123456789',
      name: 'Hosam Hasan',
      email: '30123456789123@sci.asu.edu.eg',
      phone: '0123456789',
      imageUrl: 'https://avatar.iran.liara.run/public/48',
      department: 'Mathematics',
      level: 'Level 4',
      isProfessor: true,
      academicTitle: 'Professor',
    ),
  ),
];
