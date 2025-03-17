import 'dart:developer' show log;
import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, FirebaseException, FirebaseFirestore, SetOptions;

class FireStoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  /// It can be used to add a course to the database or update an existing one
  Future<void> add({
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
  Future<void> update({
    required Map<String, dynamic> data,
    required String path,
    String? documentId,
  }) => _instance
      .collection(path)
      .doc(documentId)
      .update(data)
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));
  Future<DocumentSnapshot<Map<String, dynamic>>> get({
    required String path,
    String? documentId,
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
  Future<void> delete({required String path, String? documentId}) => _instance
      .collection(path)
      .doc(documentId)
      .delete()
      .onError<FirebaseException>(
        (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
      )
      .catchError((e) => log('$e'));
}
