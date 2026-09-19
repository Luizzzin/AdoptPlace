import 'package:adopt_place/exceptions/app_exception.dart';
import 'package:adopt_place/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Comunicação de perfis exclusivamente com a coleção /users.
class UserService {
  UserService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  /// Cria /users/{uid}, usando o mesmo UID fornecido pelo Firebase Auth.
  Future<void> createUserProfile(AppUser user) async {
    try {
      final data = user.toMap()
        ..['createdAt'] = FieldValue.serverTimestamp()
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await _users.doc(user.uid).set(data, SetOptions(merge: true));
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<AppUser> getUserProfile(String uid) async {
    try {
      final snapshot = await _users.doc(uid).get();
      if (!snapshot.exists || snapshot.data() == null) {
        throw AppException.notFound('Perfil do usuário');
      }
      return AppUser.fromMap(snapshot.id, snapshot.data()!);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  /// Atualiza somente dados de perfil; roles são administradas fora do cliente.
  Future<void> updateUserProfile(AppUser user) async {
    try {
      final data = user.toMap()
        ..remove('uid')
        ..remove('roles')
        ..remove('createdAt')
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await _users.doc(user.uid).update(data);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }
}
