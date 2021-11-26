import 'package:cloud_firestore/cloud_firestore.dart';

/// This class is used to get the data or watch for changes of data in any
/// cloud firestore database.
///
/// Supports CRUD operations.
///
/// Can be inherited by other Repository classes for data-specific implementations.
class BaseFirestoreDataRepositoy {
  /// Creates a [BaseFirestoreDataRepositoy] object.
  ///
  /// Initialized with the [_collectionName] which is the name of the collection
  /// associated with the repository.
  BaseFirestoreDataRepositoy(this._collectionName)
      : _firestore = FirebaseFirestore.instance;

  /// The [String] name of the collection associated with the repository.
  final String _collectionName;

  /// The [Firestore] instance used to access the Firestore database.
  final FirebaseFirestore _firestore;

  /// The [CollectionReference] used to access the collection associated with
  /// the repository.
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(_collectionName);

  /// Set a [DocumentReference] for the document with the given [documentId].
  ///
  /// - The [documentId] is the unique [String] identifier of the document.
  /// - [data] is the [Map] data to be added to the document. Must be appropriate
  /// formate for firestore.
  /// - [options] are the [SetOptions] to be used when setting the document.
  ///
  /// Returns a [Future] that completes with the [DocumentReference] of the
  /// document.
  Future<DocumentReference<Map<String, dynamic>>> setDocument(
    String documentId,
    Map<String, dynamic> data, {
    SetOptions? options,
  }) async {
    final DocumentReference<Map<String, dynamic>> documentReference =
        _collection.doc(documentId);
    await documentReference.set(data, options);
    return documentReference;
  }

  /// Read document data of the document with the given [documentId] from the
  /// collection associated with the repository.
  ///
  /// Returns a [Future] that completes with the document data or an error if
  /// the document does not exist.
  Future<Map<String, dynamic>> readDocument(String documentId) async {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await _collection.doc(documentId).get();
    return document.data() ?? <String, dynamic>{};
  }

  /// Watch for changes to the document with the given [documentId] in the
  /// collection associated with the repository.
  ///
  /// Returns a [Stream] that emits the document data when it changes.
  Stream<Map<String, dynamic>> watchDocument(String documentId) {
    return _collection.doc(documentId).snapshots().map(
          (DocumentSnapshot<Map<String, dynamic>> ds) =>
              ds.data() ?? <String, dynamic>{},
        );
  }

  /// Read all document data from the collection associated with the repository.
  ///
  /// WARNING: There will be high computation cost to fetch all documents from
  /// the collection if collection is big.
  ///
  /// Returns a [Future] that completes with a [List] of [Map]s each containing
  /// the associated document data.
  Future<List<Map<String, dynamic>>> readCollection({
    Object? orderByField,
    bool orderDescending = false,
    Object? whereField,
    Object? whereIsEqualTo,
    Object? whereIsNotEqualTo,
    Object? whereIsLessThan,
    Object? whereIsLessThanOrEqualTo,
    Object? whereIsGreaterThan,
    Object? whereIsGreaterThanOrEqualTo,
    Object? whereArrayContains,
    List<Object?>? whereArrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? whereIsNull,
    int? limit,
    int? limitToLast,
    List<Object?>? startAtValues,
    DocumentSnapshot<Object?>? startAtDocumentSnapshot,
    List<Object?>? startAfterValues,
    DocumentSnapshot<Object?>? startAfterDocumentSnapshot,
    List<Object?>? endAtValues,
    DocumentSnapshot<Object?>? endAtDocumentSnapshot,
    List<Object?>? endBeforeValues,
    DocumentSnapshot<Object?>? endBeforeDocumentSnapshot,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _structureQuery(
      orderByField: orderByField,
      orderDescending: orderDescending,
      whereField: whereField,
      whereIsEqualTo: whereIsEqualTo,
      whereIsNotEqualTo: whereIsNotEqualTo,
      whereIsLessThan: whereIsLessThan,
      whereIsLessThanOrEqualTo: whereIsLessThanOrEqualTo,
      whereIsGreaterThan: whereIsGreaterThan,
      whereIsGreaterThanOrEqualTo: whereIsGreaterThanOrEqualTo,
      whereArrayContains: whereArrayContains,
      whereArrayContainsAny: whereArrayContainsAny,
      whereIn: whereIn,
      whereNotIn: whereNotIn,
      whereIsNull: whereIsNull,
      limit: limit,
      limitToLast: limitToLast,
      startAtValues: startAtValues,
      startAtDocumentSnapshot: startAtDocumentSnapshot,
      startAfterValues: startAfterValues,
      startAfterDocumentSnapshot: startAfterDocumentSnapshot,
      endAtValues: endAtValues,
      endAtDocumentSnapshot: endAtDocumentSnapshot,
      endBeforeValues: endBeforeValues,
      endBeforeDocumentSnapshot: endBeforeDocumentSnapshot,
    ).get();
    return snapshot.docs
        .map<Map<String, dynamic>>(
          (QueryDocumentSnapshot<Map<String, dynamic>> docSnap) =>
              docSnap.data(),
        )
        .toList();
  }

  /// Watch for changes to the collection associated with the repository.
  ///
  /// WARNING: There will be high computation cost to fetch all documents from
  /// the collection if collection is big.
  ///
  /// Returns a [Stream] of [List] of [Map]s each containing
  /// the associated document data.
  Stream<List<Map<String, dynamic>>> watchCollection({
    Object? orderByField,
    bool orderDescending = false,
    Object? whereField,
    Object? whereIsEqualTo,
    Object? whereIsNotEqualTo,
    Object? whereIsLessThan,
    Object? whereIsLessThanOrEqualTo,
    Object? whereIsGreaterThan,
    Object? whereIsGreaterThanOrEqualTo,
    Object? whereArrayContains,
    List<Object?>? whereArrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? whereIsNull,
    int? limit,
    int? limitToLast,
    List<Object?>? startAtValues,
    DocumentSnapshot<Object?>? startAtDocumentSnapshot,
    List<Object?>? startAfterValues,
    DocumentSnapshot<Object?>? startAfterDocumentSnapshot,
    List<Object?>? endAtValues,
    DocumentSnapshot<Object?>? endAtDocumentSnapshot,
    List<Object?>? endBeforeValues,
    DocumentSnapshot<Object?>? endBeforeDocumentSnapshot,
  }) {
    return _structureQuery(
      orderByField: orderByField,
      orderDescending: orderDescending,
      whereField: whereField,
      whereIsEqualTo: whereIsEqualTo,
      whereIsNotEqualTo: whereIsNotEqualTo,
      whereIsLessThan: whereIsLessThan,
      whereIsLessThanOrEqualTo: whereIsLessThanOrEqualTo,
      whereIsGreaterThan: whereIsGreaterThan,
      whereIsGreaterThanOrEqualTo: whereIsGreaterThanOrEqualTo,
      whereArrayContains: whereArrayContains,
      whereArrayContainsAny: whereArrayContainsAny,
      whereIn: whereIn,
      whereNotIn: whereNotIn,
      whereIsNull: whereIsNull,
      limit: limit,
      limitToLast: limitToLast,
      startAtValues: startAtValues,
      startAtDocumentSnapshot: startAtDocumentSnapshot,
      startAfterValues: startAfterValues,
      startAfterDocumentSnapshot: startAfterDocumentSnapshot,
      endAtValues: endAtValues,
      endAtDocumentSnapshot: endAtDocumentSnapshot,
      endBeforeValues: endBeforeValues,
      endBeforeDocumentSnapshot: endBeforeDocumentSnapshot,
    ).snapshots().map(
          (QuerySnapshot<Map<String, dynamic>> querySnap) => querySnap.docs
              .map<Map<String, dynamic>>(
                (QueryDocumentSnapshot<Map<String, dynamic>> docSnap) =>
                    docSnap.data(),
              )
              .toList(),
        );
  }

  /// Read all document data from the collection associated with the repository.
  ///
  /// High computation cost to fetch all documents from the collection if
  /// collection is big.
  ///
  /// Returns a [Future] that completes with a [List] of [Map]s each containing
  /// the associated document data.
  Query<Map<String, dynamic>> _structureQuery({
    Object? orderByField,
    bool orderDescending = false,
    Object? whereField,
    Object? whereIsEqualTo,
    Object? whereIsNotEqualTo,
    Object? whereIsLessThan,
    Object? whereIsLessThanOrEqualTo,
    Object? whereIsGreaterThan,
    Object? whereIsGreaterThanOrEqualTo,
    Object? whereArrayContains,
    List<Object?>? whereArrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? whereIsNull,
    int? limit,
    int? limitToLast,
    List<Object?>? startAtValues,
    DocumentSnapshot<Object?>? startAtDocumentSnapshot,
    List<Object?>? startAfterValues,
    DocumentSnapshot<Object?>? startAfterDocumentSnapshot,
    List<Object?>? endAtValues,
    DocumentSnapshot<Object?>? endAtDocumentSnapshot,
    List<Object?>? endBeforeValues,
    DocumentSnapshot<Object?>? endBeforeDocumentSnapshot,
  }) {
    // Ensure [whereField] is not NULL if any other where parameters are null.
    final bool isAnyWhereParameterNotNull = whereIsEqualTo != null ||
        whereIsNotEqualTo != null ||
        whereIsLessThan != null ||
        whereIsLessThanOrEqualTo != null ||
        whereIsGreaterThan != null ||
        whereIsGreaterThanOrEqualTo != null ||
        whereArrayContains != null ||
        whereArrayContainsAny != null ||
        whereIn != null ||
        whereNotIn != null ||
        whereIsNull != null;
    if (whereField == null && isAnyWhereParameterNotNull) {
      throw ArgumentError(
        'Cannot use where parameters when whereField is NULL.',
      );
    }

    // WHERE Query
    Query<Map<String, dynamic>> query = whereField != null
        ? _collection.where(
            whereField,
            isEqualTo: whereIsEqualTo,
            isNotEqualTo: whereIsNotEqualTo,
            isLessThan: whereIsLessThan,
            isLessThanOrEqualTo: whereIsLessThanOrEqualTo,
            isGreaterThan: whereIsGreaterThan,
            isGreaterThanOrEqualTo: whereIsGreaterThanOrEqualTo,
            arrayContains: whereArrayContains,
            arrayContainsAny: whereArrayContainsAny,
            whereIn: whereIn,
            whereNotIn: whereNotIn,
            isNull: whereIsNull,
          )
        : _collection;

    // START, END Queries
    if (startAtValues != null) query = query.startAt(startAtValues);
    if (startAtDocumentSnapshot != null) {
      query = query.startAtDocument(startAtDocumentSnapshot);
    }
    if (startAfterValues != null) query = query.startAfter(startAfterValues);
    if (startAfterDocumentSnapshot != null) {
      query = query.startAfterDocument(startAfterDocumentSnapshot);
    }
    if (endAtValues != null) query = query.endAt(endAtValues);
    if (endAtDocumentSnapshot != null) {
      query = query.endAtDocument(endAtDocumentSnapshot);
    }
    if (endBeforeValues != null) query = query.endBefore(endBeforeValues);
    if (endBeforeDocumentSnapshot != null) {
      query = query.endBeforeDocument(endBeforeDocumentSnapshot);
    }

    // LIMIT Query
    if (limit != null) query = query.limit(limit);
    if (limitToLast != null) query.limitToLast(limitToLast);

    // Order Query
    final Query<Map<String, dynamic>> orderedQuery = orderByField != null
        ? query.orderBy(orderByField, descending: orderDescending)
        : query;
    return orderedQuery;
  }

  /// Update a document in the collection associated with the repository.
  ///
  /// Returns a [Future] that completes with the updated document reference.
  Future<DocumentReference<Map<String, dynamic>>> updateDocument(
    String documentId,
    Map<String, dynamic> data,
  ) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        _collection.doc(documentId);
    await docRef.update(data);
    return docRef;
  }

  /// Delete a document from the collection associated with the repository.
  ///
  /// Returns a [Future] that completes with the deleted document reference.
  Future<DocumentReference<Map<String, dynamic>>> deleteDocument(
    String documentId,
  ) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        _collection.doc(documentId);
    await docRef.delete();
    return docRef;
  }

  /// Delete all documents from the collection associated with the repository.
  ///
  /// Returns a [Future] that completes with the deleted document references.
  Future<void> deleteAllDocuments() async {
    final QuerySnapshot<Map<String, dynamic>> docRefs = await _collection.get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnap in docRefs.docs) {
      await docSnap.reference.delete();
    }
  }
}
