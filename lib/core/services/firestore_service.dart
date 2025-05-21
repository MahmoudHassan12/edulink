import 'package:cloud_firestore/cloud_firestore.dart'
    show
        DocumentReference,
        FieldPath,
        FieldValue,
        FirebaseException,
        FirebaseFirestore,
        GeoPoint,
        Query,
        QuerySnapshot,
        SetOptions;

import 'package:edu_link/core/errors/exceptions.dart' show DatabaseException;
import 'package:edu_link/core/helpers/query_entity.dart'
    show FieldEntity, QueryEntity;

// class FirestoreService {
//   const FirestoreService();
//   static final FirebaseFirestore _instance = FirebaseFirestore.instance;

//   /// It can be used to add a course to the database or update an existing one
//   Future<void> addDocument({
//     required Map<String, dynamic> data,
//     required String path,
//     String? documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .set(data, SetOptions(merge: true))
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));

//   Future<void> addListInDocument({
//     required String path,
//     required String listKey,
//     required List<dynamic> list,
//     String? documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .update({listKey: FieldValue.arrayUnion(list)})
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));

//   Future<void> removeListInDocument({
//     required String path,
//     required String listKey,
//     required List<dynamic> list,
//     String? documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .update({listKey: FieldValue.arrayRemove(list)})
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));

//   Future<void> addNestedListInListInDocument({
//     required String path,
//     required String listKey,
//     required String nestedListKey,
//     required String nestedId,
//     required List<dynamic> list,
//     String? documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .update({
//         '$listKey.$nestedListKey.$nestedId': FieldValue.arrayUnion(list),
//       })
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));

//   Future<void> update({
//     required Map<String, dynamic> data,
//     required String path,
//     String? documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .set(data, SetOptions(merge: true))
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));
//   Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
//     required String path,
//     required String documentId,
//   }) => _instance
//       .collection(path)
//       .doc(documentId)
//       .get()
//       .onError<FirebaseException>((e, _) {
//         log('Code: ${e.code}, Message: ${e.message}, $e');
//         throw e;
//       })
//       .catchError((e) {
//         log('$e');
//         throw e;
//       });

//   Future<List<Map<String, dynamic>>?> getMultibleDocuments({
//     required String path,
//     required List<String?>? documentIds,
//   }) => _instance
//       .collection(path)
//       .where(FieldPath.documentId, whereIn: documentIds)
//       .get()
//       .then((value) => value.docs.map((e) => e.data()).toList());

//   // if (documentIds == null) return null;
//   // return Future.wait(
//   //   documentIds
//   //       .map(
//   //         (id) => _instance
//   //             .collection(path)
//   //             .doc(id)
//   //             .get()
//   //             .onError<FirebaseException>((e, _) {
//   //               log('Code: ${e.code}, Message: ${e.message}, $e');
//   //               throw e;
//   //             })
//   //             .catchError((e) {
//   //               log('$e');
//   //               throw e;
//   //             }),
//   //       )
//   //       .toList(),
//   // );
// Future<QuerySnapshot<Map<String, dynamic>>> getAll({required String path}) =>
//       _instance
//           .collection(path)
//           .get()
//           .onError<FirebaseException>((e, _) {
//             log('Code: ${e.code}, Message: ${e.message}, $e');
//             throw e;
//           })
//           .catchError((e) {
//             log('$e');
//             throw e;
//           });

//   /// Streams
//   Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
//     required String path,
//     required String documentId,
//     OrderByEntity? orderBy,
//   }) async* {
//     var collection = _instance.collection(path);
//     if (orderBy != null) {
//       collection = collection
//         ..orderBy(orderBy.field, descending: orderBy.descending);
//     }
//     final snapshots = collection.doc(documentId).snapshots();
//     await for (final snapshot in snapshots) {
//       yield snapshot;
//     }
//   }

//   Stream<List<Map<String, dynamic>>> getMultibleDocumentStream({
//     required String path,
//     List<String?>? documentIds,
//   }) => _instance
//       .collection(path)
//       .where(FieldPath.documentId, whereIn: documentIds)
//       .snapshots()
//       .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

//   Stream<List<DocumentSnapshot<Map<String, dynamic>>>>
//   getMultibleDocumentStreamWithSpecificIds({
//     required String path,
//     required String field,
//     String? documentId,
//   }) async* {
//     if (documentId == null || documentId.isEmpty) {
//       yield [];
//       return;
//     }
//     final stream = _instance
//         .collection(path)
//         .where(field, arrayContains: documentId)
//         .snapshots();
//     await for (final snapshot in stream) {
//       yield snapshot.docs;
//     }
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> getAllStream({
//     required String path,
//   }) async* {
//     final snapshots = _instance.collection(path).snapshots();
//     await for (final snapshot in snapshots) {
//       yield snapshot;
//     }
//   }

//  Future<void> delete({required String path, String? documentId}) => _instance
//       .collection(path)
//       .doc(documentId)
//       .delete()
//       .onError<FirebaseException>(
//         (e, _) => log('Code: ${e.code}, Message: ${e.message}, $e'),
//       )
//       .catchError((e) => log('$e'));
// }

class FirestoreService {
  const FirestoreService();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> _stripEmpty(Map<String, dynamic> src) => src.map((
    key,
    rawValue,
  ) {
    if (key == 'helpful') {
      return MapEntry<String, dynamic>(key, rawValue);
    }
    bool isItemEmpty(Object? item) =>
        item == null ||
        item == 'null' ||
        (item is String && item.isEmpty) ||
        (item is num && item.isNaN) ||
        (item is List && item.isEmpty) ||
        (item is Map && item.isEmpty) ||
        (item is GeoPoint && (item.latitude.isNaN || item.longitude.isNaN));
    if (isItemEmpty(rawValue)) {
      return MapEntry<String, dynamic>(key, FieldValue.delete());
    }
    if (rawValue is Map<String, dynamic>) {
      var nested = _stripEmpty(rawValue);
      return MapEntry<String, dynamic>(
        key,
        nested.isNotEmpty ? nested : FieldValue.delete(),
      );
    }
    if (rawValue is List) {
      var cleanedList = rawValue.where((item) => !isItemEmpty(item)).toList();
      return MapEntry<String, dynamic>(
        key,
        cleanedList.isNotEmpty ? cleanedList : FieldValue.delete(),
      );
    }
    return MapEntry<String, dynamic>(key, rawValue);
  });

  Future<void> _set({
    required DocumentReference<Map<String, dynamic>> document,
    required Map<String, dynamic> data,
  }) => document
      .set(_stripEmpty(data), SetOptions(merge: true))
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<void> addDocument({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) => _set(document: _firestore.collection(path).doc(documentId), data: data);

  Future<void> _updateValue({
    required DocumentReference<Map<String, dynamic>> document,
    required String key,
    required List<Object?> data,
  }) => document
      .update(<String, FieldValue>{key: FieldValue.arrayUnion(data)})
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<void> addValue({
    required String path,
    required String documentId,
    required String key,
    required List<Object?> data,
  }) => _updateValue(
    document: _firestore.collection(path).doc(documentId),
    key: key,
    data: data,
  );

  Future<void> addSubDocument({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required String subDocumentId,
    required Map<String, dynamic> data,
  }) => _set(
    document: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath)
        .doc(subDocumentId),
    data: data,
  );

  Future<void> addSubValue({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required String subDocumentId,
    required String key,
    required List<Object?> data,
  }) => _updateValue(
    document: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath)
        .doc(subDocumentId),
    key: key,
    data: data,
  );

  /// Updaters
  Future<void> _updateList({
    required Future<QuerySnapshot<Map<String, dynamic>>> snapshot,
    required Map<String, dynamic> data,
  }) => snapshot
      .then((snapshot) {
        var batch = _firestore.batch();
        snapshot.docs
            .map(
              (doc) => batch.set(
                doc.reference,
                _stripEmpty(data),
                SetOptions(merge: true),
              ),
            )
            .toList();
        return batch.commit();
      })
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<void> updateCollection({
    required String path,
    required Map<String, dynamic> data,
  }) => _updateList(snapshot: _firestore.collection(path).get(), data: data);

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) => _set(document: _firestore.collection(path).doc(documentId), data: data);

  Future<void> updateDocuments({
    required String path,
    required Map<String, dynamic> data,
    required List<String> documenstId,
  }) => _updateList(
    snapshot: _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documenstId)
        .get(),
    data: data,
  );

  Future<void> updateSubDocument({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required String subDocumentId,
    required Map<String, dynamic> data,
  }) => _set(
    document: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath)
        .doc(subDocumentId),
    data: data,
  );

  Future<void> updateKey({
    required String path,
    required String oldKey,
    required String newKey,
  }) => _firestore
      .collection(path)
      .get()
      .then((snapshot) {
        var batch = _firestore.batch();
        snapshot.docs.map((doc) {
          var data = doc.data();
          if (data.containsKey(oldKey)) {
            return batch
              ..update(doc.reference, <String, dynamic>{newKey: data[oldKey]})
              ..update(doc.reference, <String, FieldValue>{
                oldKey: FieldValue.delete(),
              });
          }
        });
        return batch.commit();
      })
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<bool> isDocumentExists({
    required String path,
    required String documentId,
  }) => _firestore
      .collection(path)
      .doc(documentId)
      .get()
      .then((doc) => doc.exists)
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  /// Normal getters
  Future<List<Map<String, dynamic>>> _getList({
    required Future<QuerySnapshot<Map<String, dynamic>>> snapshot,
  }) => snapshot
      .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<List<Map<String, dynamic>>> getCollection({required String path}) =>
      _getList(snapshot: _firestore.collection(path).get());

  Future<Map<String, dynamic>> getDocument({
    required String path,
    required String documentId,
  }) => _firestore
      .collection(path)
      .doc(documentId)
      .get()
      .then((doc) => doc.data()!)
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<List<Map<String, dynamic>>> getDocuments({
    required String path,
    required List<String> documentIds,
  }) => _getList(
    snapshot: _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documentIds)
        .get(),
  );

  Future<List<Map<String, dynamic>>> getSubCollection({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
  }) => _getList(
    snapshot: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath)
        .get(),
  );

  /// Getters with query
  Future<List<Map<String, dynamic>>> _getWithQuery({
    required Query<Map<String, dynamic>> dataQuery,
    required QueryEntity query,
  }) {
    var temp = dataQuery;
    if (query.fields?.isNotEmpty ?? false) {
      temp = _fileds(query.fields!, temp);
    }
    if (query.orderBy?.isNotEmpty ?? false) {
      temp = temp.orderBy(query.orderBy!, descending: query.descending);
    }
    if (query.limit != null) {
      temp = temp.limit(query.limit!);
    }
    return temp
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .onError<FirebaseException>(
          (error, stackTrace) => throw DatabaseException(error, stackTrace),
        );
  }

  Future<List<Map<String, dynamic>>> getCollectionWithQuery({
    required String path,
    required QueryEntity query,
  }) => _getWithQuery(dataQuery: _firestore.collection(path), query: query);

  Future<List<Map<String, dynamic>>> getDocumentsWithQuery({
    required String path,
    required List<String> documentIds,
    required QueryEntity query,
  }) => _getWithQuery(
    dataQuery: _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documentIds),
    query: query,
  );

  Future<List<Map<String, dynamic>>> getSubCollectionWithQuery({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required QueryEntity query,
  }) => _getWithQuery(
    dataQuery: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath),
    query: query,
  );

  /// Stream getters
  Stream<List<Map<String, dynamic>>> _streamList({
    required Stream<QuerySnapshot<Map<String, dynamic>>> snapshot,
  }) => snapshot
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .handleError(
        (Object error, StackTrace stackTrace) =>
            throw DatabaseException(error as FirebaseException, stackTrace),
      );

  Stream<List<Map<String, dynamic>>> streamCollection({required String path}) =>
      _streamList(snapshot: _firestore.collection(path).snapshots());

  Stream<Map<String, dynamic>> streamDocument({
    required String path,
    required String documentId,
  }) => _firestore
      .collection(path)
      .doc(documentId)
      .snapshots()
      .map((snapshot) => snapshot.data()!)
      .handleError(
        (Object error, StackTrace stackTrace) =>
            throw DatabaseException(error as FirebaseException, stackTrace),
      );

  Stream<List<Map<String, dynamic>>> streamDocuments({
    required String path,
    required List<String> documentIds,
  }) => _streamList(
    snapshot: _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documentIds)
        .snapshots(),
  );

  Stream<List<Map<String, dynamic>>> streamSubCollection({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
  }) => _streamList(
    snapshot: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath)
        .snapshots(),
  );

  /// Stream getters with query
  Stream<List<Map<String, dynamic>>> _streamWithQuery({
    required Query<Map<String, dynamic>> dataQuery,
    required QueryEntity query,
  }) {
    var temp = dataQuery;
    if (query.fields?.isNotEmpty ?? false) {
      temp = _fileds(query.fields!, temp);
    }
    if (query.orderBy?.isNotEmpty ?? false) {
      temp = temp.orderBy(query.orderBy!, descending: query.descending);
    }
    if (query.limit != null) {
      temp = temp.limit(query.limit!);
    }
    return temp
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .handleError(
          (Object error, StackTrace stackTrace) =>
              throw DatabaseException(error as FirebaseException, stackTrace),
        );
  }

  Stream<List<Map<String, dynamic>>> streamCollectionWithQuery({
    required String path,
    required QueryEntity query,
  }) => _streamWithQuery(dataQuery: _firestore.collection(path), query: query);

  Stream<List<Map<String, dynamic>>> streamDocumentsWithQuery({
    required String path,
    required List<String> documentIds,
    required QueryEntity query,
  }) => _streamWithQuery(
    dataQuery: _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documentIds),
    query: query,
  );

  Stream<List<Map<String, dynamic>>> streamSubCollectionWithQuery({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required QueryEntity query,
  }) => _streamWithQuery(
    dataQuery: _firestore
        .collection(collectionPath)
        .doc(documentId)
        .collection(subCollectionPath),
    query: query,
  );

  /// Deleters

  Future<void> _deleteList(
    Future<QuerySnapshot<Map<String, dynamic>>> snapshot,
  ) => snapshot.then((snapshot) {
    var batch = _firestore.batch();
    snapshot.docs.map((doc) => batch.delete(doc.reference));
    return batch.commit();
  });

  Future<void> deleteCollection({required String path}) =>
      _deleteList(_firestore.collection(path).get());

  Future<void> deleteDocument({
    required String path,
    required String documentId,
  }) => _firestore
      .collection(path)
      .doc(documentId)
      .delete()
      .onError<FirebaseException>((e, _) => throw DatabaseException(e));

  Future<void> deleteDocuments({
    required String path,
    required List<String> documentIds,
  }) => _deleteList(
    _firestore
        .collection(path)
        .where(FieldPath.documentId, whereIn: documentIds)
        .get(),
  );

  Future<void> deleteSubValue({
    required String collectionPath,
    required String documentId,
    required String subCollectionPath,
    required String subDocumentId,
    required String key,
    required List<Map<String, dynamic>> data,
  }) async {
    final batch = _firestore.batch();
    for (final item in data) {
      final docRef = _firestore
          .collection(collectionPath)
          .doc(documentId)
          .collection(subCollectionPath)
          .doc(subDocumentId);
      batch.update(docRef, <String, FieldValue>{
        key: FieldValue.arrayRemove([item]),
      });
    }
    await batch.commit();
  }

  Query<Map<String, dynamic>> _fileds(
    List<FieldEntity> fields,
    Query<Map<String, dynamic>> dataQuery,
  ) => fields.fold(
    dataQuery,
    (prevQuery, field) => prevQuery.where(
      field.field,
      isEqualTo: field.isEqualTo,
      isNotEqualTo: field.isNotEqualTo,
      isLessThan: field.isLessThan,
      isLessThanOrEqualTo: field.isLessThanOrEqualTo,
      isGreaterThan: field.isGreaterThan,
      isGreaterThanOrEqualTo: field.isGreaterThanOrEqualTo,
      arrayContains: field.arrayContains,
      arrayContainsAny: field.arrayContainsAny,
      whereIn: field.whereIn,
      whereNotIn: field.whereNotIn,
      isNull: field.isNull,
    ),
  );
}
