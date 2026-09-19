import 'package:cloud_firestore/cloud_firestore.dart';

enum AdoptionRequestStatus { pending, approved, rejected, cancelled }

class AdoptionRequest {
  const AdoptionRequest({
    required this.id,
    required this.animalId,
    required this.adopterId,
    required this.donorId,
    required this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String animalId;
  final String adopterId;
  final String donorId;
  final AdoptionRequestStatus status;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() => {
    'animalId': animalId,
    'adopterId': adopterId,
    'donorId': donorId,
    'status': status.name,
    'message': message,
    if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
    if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
  };

  factory AdoptionRequest.fromMap(String id, Map<String, dynamic> map) =>
      AdoptionRequest(
        id: id,
        animalId: map['animalId'] as String? ?? '',
        adopterId: map['adopterId'] as String? ?? '',
        donorId: map['donorId'] as String? ?? '',
        status: _statusFrom(map['status']),
        message: map['message'] as String?,
        createdAt: _dateFrom(map['createdAt']),
        updatedAt: _dateFrom(map['updatedAt']),
      );

  AdoptionRequest copyWith({
    String? id,
    String? animalId,
    String? adopterId,
    String? donorId,
    AdoptionRequestStatus? status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AdoptionRequest(
        id: id ?? this.id,
        animalId: animalId ?? this.animalId,
        adopterId: adopterId ?? this.adopterId,
        donorId: donorId ?? this.donorId,
        status: status ?? this.status,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  static AdoptionRequestStatus _statusFrom(dynamic value) {
    for (final status in AdoptionRequestStatus.values) {
      if (status.name == value) return status;
    }
    return AdoptionRequestStatus.pending;
  }

  static DateTime? _dateFrom(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return null;
  }
}
