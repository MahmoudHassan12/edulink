import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/answer_entity.dart'
    show AnswerEntity;
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart'
    show QuestionEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/shared_pref.dart'
    show SharedPrefSingleton;
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:edu_link/core/services/firestore_service.dart'
    show FirestoreService;
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

class CoursesRepo {
  const CoursesRepo();
  static const FirestoreService _fireStore = FirestoreService();
  static const String _coursesPath = Endpoints.courses;

  Future<String> uploadImage(File file) async =>
      const SupabaseService().upload(_coursesPath, 'images', file);

  Future<void> add({required Map<String, dynamic> data, String? documentId}) =>
      _fireStore
          .addDocument(data: data, path: _coursesPath, documentId: documentId)
          .then((_) => log('Course added successfully!'))
          .onError<FirebaseException>((e, _) => log('Failed to add course: $e'))
          .catchError((e) => log('Failed to add course: $e'));

  Future<void> addCoursesIds(List<String> courseIds) => _fireStore
      .addListInDocument(
        path: Endpoints.users,
        listKey: 'coursesIds',
        list: courseIds,
        documentId: getUser?.id,
      )
      .then((_) {
        final courses = List<CourseEntity>.empty(growable: true);
        courseIds.map((id) => courses.add(CourseEntity(id: id))).toList();
        final user = getUser?.copyWith(courses: courses);
        SharedPrefSingleton.setString(
          Endpoints.user,
          jsonEncode(user?.toMap(toSharedPref: true)),
        );
        log('User added successfully!');
      });

  Future<void> addQuestion(QuestionEntity question, String? courseId) =>
      _fireStore
          .addListInDocument(
            path: _coursesPath,
            listKey: 'questions',
            list: [question.toMap()],
            documentId: courseId,
          )
          .then((_) {
            log('Questions added successfully!');
          })
          .onError<FirebaseException>((e, _) {
            log('Failed to add questions: $e');
          })
          .catchError((e) {
            log('Failed to add questions: $e');
          });

  Future<List<CourseEntity>?> getMultibleCourses(List<String?>? courseIds) =>
      _fireStore
          .getMultibleDocuments(path: _coursesPath, documentIds: courseIds)
          .then((docs) async {
            log('${docs?.length} Courses fetched successfully!');
            return Future.wait(
              docs?.map((e) async {
                    final data = e.data();
                    final professor = await const UserRepo().get(
                      documentId: data?['professorId'],
                      isProfessor: true,
                    );
                    return CourseEntity.fromMap(
                      data,
                    ).copyWith(professor: professor);
                  }).toList() ??
                  <Future<CourseEntity>>[],
            );
          });

  Stream<List<CourseEntity>?> getMultibleCoursesStream(
    List<String?>? courseIds,
  ) async* {
    yield* _fireStore
        .getMultibleDocumentStream(path: _coursesPath, documentIds: courseIds)
        .asyncMap((docs) async {
          log('${docs.length} Courses fetched successfully!');
          return Future.wait(
            docs.map((e) async {
              final data = e.data();
              final professor = await const UserRepo().get(
                documentId: data?['professorId'],
                isProfessor: true,
              );
              return CourseEntity.fromMap(data).copyWith(professor: professor);
            }).toList(),
          );
        });
  }

  Future<void> update({
    required Map<String, dynamic> data,
    String? documentId,
  }) => _fireStore
      .update(data: data, path: _coursesPath, documentId: documentId)
      .then((_) => log('Course updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update course: $e'))
      .catchError((e) => log('Failed to update course: $e'));

  Future<List<CourseEntity>?> getAll() => _fireStore
      .getAll(path: _coursesPath)
      .then((e) async {
        final docs = e.docs;
        log('${docs.length} Courses fetched successfully!');
        final courses = await Future.wait<CourseEntity>(
          docs.map((e) async {
            final data = e.data();
            final professor = await const UserRepo().get(
              documentId: data['professorId'],
              isProfessor: true,
            );
            final course = CourseEntity.fromMap(
              data,
            ).copyWith(professor: professor, questions: _questions);
            return course;
          }),
        );
        return courses;
      })
      .onError<FirebaseException>(
        (e, _) => throw Exception('Failed to fetch courses: $e'),
      )
      .catchError((e) => throw Exception('Failed to fetch courses: $e'));

  Future<void> delete({String? documentId}) => _fireStore
      .delete(path: _coursesPath, documentId: documentId)
      .then((_) => log('Course deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete course: $e'))
      .catchError((e) => log('Failed to delete course: $e'));
}

List<QuestionEntity> _questions = [
  QuestionEntity(
    question: 'What is Flutter?',
    answers: [
      AnswerEntity(
        answer:
            'Flutter is a mobile app development framework created by Google.',
        user: const UserEntity(
          name: 'Hosam Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/30',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'Flutter is an open-source mobile app '
            'development framework created by Google.',
        user: const UserEntity(
          name: 'Mahmoud Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/31',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Yousef Saber',
      imageUrl: 'https://avatar.iran.liara.run/public/32',
    ),
    date: DateTime.now(),
  ),
  QuestionEntity(
    question: 'What is Dart?',
    answers: [
      AnswerEntity(
        answer:
            'Dart is a programming language '
            'created by Google that runs on Flutter.',
        user: const UserEntity(
          name: 'Yousef Saber',
          imageUrl: 'https://avatar.iran.liara.run/public/32',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'Dart is an open-source programming language '
            'created by Google that runs on Flutter.',
        user: const UserEntity(
          name: 'Mahmoud Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/31',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Hosam Hasan',
      imageUrl: 'https://avatar.iran.liara.run/public/30',
    ),
    date: DateTime.now(),
  ),
  QuestionEntity(
    question: 'What is a widget?',
    answers: [
      AnswerEntity(
        answer: 'A widget is a building block of user interface in Flutter.',
        user: const UserEntity(
          name: 'Yousef Saber',
          imageUrl: 'https://avatar.iran.liara.run/public/32',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'A widget is an abstract representation '
            'of a user interface in Flutter.',
        user: const UserEntity(
          name: 'Hosam Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/30',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Mahmoud Hasan',
      imageUrl: 'https://avatar.iran.liara.run/public/31',
    ),
    date: DateTime.now(),
  ),
];
