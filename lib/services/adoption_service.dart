import 'package:adopt_place/exceptions/app_exception.dart';
import 'package:adopt_place/models/adoption_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Comunicação de solicitações exclusivamente com /adoptionRequests.
class AdoptionService {
  AdoptionService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _requests =>
      _firestore.collection('adoptionRequests');

  Future<AdoptionRequest> createRequest(AdoptionRequest request) async {
    try {
      final reference = _requests.doc();
      final data = request.toMap()
        ..['status'] = AdoptionRequestStatus.pending.name
        ..['createdAt'] = FieldValue.serverTimestamp()
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await reference.set(data);
      return request.copyWith(
        id: reference.id,
        status: AdoptionRequestStatus.pending,
      );
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<AdoptionRequest> getRequest(String requestId) async {
    try {
      final snapshot = await _requests.doc(requestId).get();
      if (!snapshot.exists || snapshot.data() == null) {
        throw AppException.notFound('Solicitação de adoção');
      }
      return AdoptionRequest.fromMap(snapshot.id, snapshot.data()!);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<List<AdoptionRequest>> listRequestsForAdopter(
    String adopterId, {
    int? limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) =>
      _listRequests(
        field: 'adopterId',
        userId: adopterId,
        limit: limit,
        startAfterDocument: startAfterDocument,
      );

  Future<List<AdoptionRequest>> listRequestsForDonor(
    String donorId, {
    int? limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) =>
      _listRequests(
        field: 'donorId',
        userId: donorId,
        limit: limit,
        startAfterDocument: startAfterDocument,
      );

  Future<void> updateRequestStatus(
    String requestId,
    AdoptionRequestStatus status,
  ) async {
    try {
      await _requests.doc(requestId).update({
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> cancelRequest(String requestId) =>
      updateRequestStatus(requestId, AdoptionRequestStatus.cancelled);

  Future<List<AdoptionRequest>> _listRequests({
    required String field,
    required String userId,
    int? limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _requests
          .where(field, isEqualTo: userId)
          .orderBy('createdAt', descending: true);
      if (startAfterDocument != null) {
        query = query.startAfterDocument(startAfterDocument);
      }
      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map(
            (document) => AdoptionRequest.fromMap(
              document.id,
              document.data(),
            ),
          )
          .toList(growable: false);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }
}
