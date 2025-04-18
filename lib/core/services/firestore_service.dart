import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart'
    show
        DocumentSnapshot,
        FieldPath,
        FieldValue,
        FirebaseException,
        FirebaseFirestore,
        QuerySnapshot,
        SetOptions;
import 'package:edu_link/core/domain/entities/order_by_entity.dart';

class FirestoreService {
  const FirestoreService();
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  /// It can be used to add a course to the database or update an existing one
  Future<void> addDocument({
    required Map<String, dynamic> data,
    required String path,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .set(data, SetOptions(merge: true))
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));

  Future<void> addListInDocument({
    required String path,
    required String listKey,
    required List<dynamic> list,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .update({listKey: FieldValue.arrayUnion(list)})
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));

  Future<void> removeListInDocument({
    required String path,
    required String listKey,
    required List<dynamic> list,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .update({listKey: FieldValue.arrayRemove(list)})
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));

  Future<void> addNestedListInListInDocument({
    required String path,
    required String listKey,
    required String nestedListKey,
    required String nestedId,
    required List<dynamic> list,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .update({
        '$listKey.$nestedListKey.$nestedId': FieldValue.arrayUnion(list),
      })
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));

  Future<void> update({
    required Map<String, dynamic> data,
    required String path,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .set(data, SetOptions(merge: true))
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String path,
    required String documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .get()
      .onError<FirebaseException>((e, _) {
        log('Code: ${e.code}, Message: ${e.message}, $e');
        throw e;
      })
      .catchError((e) {
        log('$e');
        throw e;
      });

  Future<List<Map<String, dynamic>>?> getMultibleDocuments({
    required String path,
    required List<String?>? documentIds,
  }) => _instance
      .collection(path)
      .where(FieldPath.documentId, whereIn: documentIds)
      .get()
      .then((value) => value.docs.map((e) => e.data()).toList());

  // if (documentIds == null) return null;
  // return Future.wait(
  //   documentIds
  //       .map(
  //         (id) => _instance
  //             .collection(path)
  //             .doc(id)
  //             .get()
  //             .onError<FirebaseException>((e, _) {
  //               log('Code: ${e.code}, Message: ${e.message}, $e');
  //               throw e;
  //             })
  //             .catchError((e) {
  //               log('$e');
  //               throw e;
  //             }),
  //       )
  //       .toList(),
  // );
  Future<QuerySnapshot<Map<String, dynamic>>> getAll({required String path}) =>
      _instance
          .collection(path)
          .get()
          .onError<FirebaseException>((e, _) {
            log('Code: ${e.code}, Message: ${e.message}, $e');
            throw e;
          })
          .catchError((e) {
            log('$e');
            throw e;
          });

  /// Streams
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
    required String path,
    required String documentId,
    OrderByEntity? orderBy,
  }) async* {
    var collection = _instance.collection(path);
    if (orderBy != null) {
      collection =
          collection..orderBy(orderBy.field, descending: orderBy.descending);
    }
    final snapshots = collection.doc(documentId).snapshots();
    await for (final snapshot in snapshots) {
      yield snapshot;
    }
  }

  Stream<List<Map<String, dynamic>>> getMultibleDocumentStream({
    required String path,
    List<String?>? documentIds,
  }) => _instance
      .collection(path)
      .where(FieldPath.documentId, whereIn: documentIds)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>>
  getMultibleDocumentStreamWithSpecificIds({
    required String path,
    required String field,
    String? documentId,
  }) async* {
    if (documentId == null || documentId.isEmpty) {
      yield [];
      return;
    }
    final stream =
        _instance
            .collection(path)
            .where(field, arrayContains: documentId)
            .snapshots();
    await for (final snapshot in stream) {
      yield snapshot.docs;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStream({
    required String path,
  }) async* {
    final snapshots = _instance.collection(path).snapshots();
    await for (final snapshot in snapshots) {
      yield snapshot;
    }
  }

  Future<void> delete({required String path, String? documentId}) => _instance
      .collection(path)
      .doc(documentId)
      .delete()
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));
}
