import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { adopter, donor, admin }

class AppUser {
  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
    this.phone,
    this.photoUrl,
  });

  /// Espelha [FirebaseAuth.instance.currentUser?.uid] no modelo da aplicação.
  /// Senhas e credenciais nunca fazem parte deste documento.
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final List<UserRole> roles;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'roles': roles.map((role) => role.name).toList(growable: false),
    'photoUrl': photoUrl,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) => AppUser(
    uid: uid,
    name: map['name'] as String? ?? '',
    email: map['email'] as String? ?? '',
    phone: map['phone'] as String?,
    roles: _rolesFrom(map),
    photoUrl: map['photoUrl'] as String?,
    createdAt: _dateFrom(map['createdAt']),
    updatedAt: _dateFrom(map['updatedAt']),
  );

  AppUser copyWith({
    String? name,
    String? email,
    String? phone,
    List<UserRole>? roles,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppUser(
    uid: uid,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    roles: roles ?? this.roles,
    photoUrl: photoUrl ?? this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  static DateTime _dateFrom(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  static List<UserRole> _rolesFrom(Map<String, dynamic> map) {
    final storedRoles = map['roles'];
    final roleNames = storedRoles is List
        ? storedRoles.whereType<String>()
        : <String>[if (map['role'] is String) map['role'] as String];

    final roles = <UserRole>[];
    for (final roleName in roleNames) {
      for (final role in UserRole.values) {
        if (role.name == roleName && !roles.contains(role)) {
          roles.add(role);
        }
      }
    }
    return roles.isEmpty ? const [UserRole.adopter] : roles;
  }
}
