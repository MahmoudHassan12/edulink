import 'dart:developer' show log;
import 'dart:io' show File;
import 'package:edu_link/core/constants/endpoints.dart' show Endpoints;
import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart'
    show QuestionEntity;
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/query_entity.dart';
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
      .addValue(
        path: Endpoints.users,
        documentId: getUser!.id!,
        key: 'coursesIds',
        data: courseIds,
      )
      .then((_) => log('Courses added successfully!'));

  Future<void> addQuestion(QuestionEntity question, String courseId) =>
      _fireStore
          .addSubDocument(
            collectionPath: _coursesPath,
            documentId: courseId,
            subCollectionPath: 'questions',
            subDocumentId: question.id!,
            data: question.toMap(),
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

  // Future<void> deleteQuestion(QuestionEntity question, String? courseId) =>
  //     _fireStore // TODO(Yousef): Handle error
  //         .deleteDocument(
  //           path: _coursesPath,
  //           listKey: 'questions',
  //           list: [question.toMap()],
  //           documentId: courseId,
  //         )
  //         .then((_) => log('Question deleted successfully!'));

  Future<void> addAnswer(
    String courseId,
    String questionId,
    AnswerEntity answer,
  ) async {
    await _fireStore.addSubValue(
      collectionPath: _coursesPath,
      documentId: courseId,
      subCollectionPath: 'questions',
      subDocumentId: questionId,
      key: 'answers',
      data: [answer.toMap()],
    );
  }

  Stream<List<QuestionEntity>> streamQuestions(String courseId) => _fireStore
      .streamSubCollectionWithQuery(
        collectionPath: _coursesPath,
        documentId: courseId,
        subCollectionPath: 'questions',
        query: const QueryEntity(orderBy: 'date', descending: true),
      )
      .map((data) => data.map((e) => QuestionEntity.fromMap(e)).toList());

  Future<void> deleteAnswer(
    String courseId,
    String questionId,
    AnswerEntity answer,
  ) async {
    await _fireStore.deleteSubValue(
      collectionPath: _coursesPath,
      documentId: courseId,
      subCollectionPath: 'questions',
      subDocumentId: questionId,
      key: 'answers',
      data: [answer.toMap()],
    );
  }

  Future<CourseEntity> getCourse(String courseId) => _fireStore
      .getDocument(path: _coursesPath, documentId: courseId)
      .then((data) async {
        log('Course fetched successfully!');
        return CourseEntity.fromMap(data);
      });

  Future<List<CourseEntity>?> getMultibleCourses(List<String> courseIds) =>
      _fireStore.getDocuments(path: _coursesPath, documentIds: courseIds).then((
        data,
      ) async {
        log('${data.length} Courses fetched successfully!');
        return Future.wait(
          data.map((e) async {
            final professor = await const UserRepo().get(
              documentId: e['professorId'],
            );
            return CourseEntity.fromMap(e).copyWith(professor: professor);
          }).toList(),
        );
      });

  Stream<List<CourseEntity>?> getMultibleCoursesStream(
    List<String> courseIds,
  ) async* {
    yield* _fireStore
        .streamDocuments(path: _coursesPath, documentIds: courseIds)
        .asyncMap((docs) async {
          log('${docs.length} Courses fetched successfully!');
          return Future.wait<CourseEntity>(
            docs.map((e) async {
              final professorStream = const UserRepo().getStream(
                documentId: e['professorId'],
                isProfessor: true,
              );
              await for (final professor in professorStream) {
                return CourseEntity.fromMap(e).copyWith(professor: professor);
              }
              throw Exception('Professor stream ended without value');
            }).toList(),
          );
        });
  }

  Future<void> update({
    required Map<String, dynamic> data,
    required String documentId,
  }) => _fireStore
      .updateDocument(data: data, path: _coursesPath, documentId: documentId)
      .then((_) => log('Course updated successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to update course: $e'))
      .catchError((e) => log('Failed to update course: $e'));

  Future<List<CourseEntity>?> getAll() => _fireStore
      .getCollection(path: _coursesPath)
      .then((e) async {
        log('${e.length} Courses fetched successfully!');
        final courses = await Future.wait<CourseEntity>(
          e.map((data) async {
            final professor = await const UserRepo().get(
              documentId: data['professorId'],
            );
            final course = CourseEntity.fromMap(
              data,
            ).copyWith(professor: professor);
            return course;
          }),
        );
        return courses;
      })
      .onError<FirebaseException>(
        (e, _) => throw Exception('Failed to fetch courses: $e'),
      )
      .catchError((e) => throw Exception('Failed to fetch courses: $e'));

  Future<void> delete({required String documentId}) => _fireStore
      .deleteDocument(path: _coursesPath, documentId: documentId)
      .then((_) => log('Course deleted successfully!'))
      .onError<FirebaseException>((e, _) => log('Failed to delete course: $e'))
      .catchError((e) => log('Failed to delete course: $e'));
}
