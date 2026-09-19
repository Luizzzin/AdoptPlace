import 'dart:typed_data';

import 'package:adopt_place/exceptions/app_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Comunicação de imagens exclusivamente com o Firebase Storage.
class StorageService {
  StorageService({FirebaseStorage? storage})
    : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  /// Envia bytes de uma imagem e devolve a URL que deve ser salva no Firestore.
  Future<String> uploadAnimalImage({
    required String animalId,
    required Uint8List bytes,
    required String fileName,
    String? contentType,
  }) async {
    if (animalId.isEmpty || bytes.isEmpty || fileName.isEmpty) {
      throw const AppException(
        code: 'invalid-image-data',
        message: 'Informe uma imagem e um animal válidos.',
      );
    }

    try {
      final safeFileName = fileName.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
      final path =
          'animals/$animalId/${DateTime.now().millisecondsSinceEpoch}_$safeFileName';
      final reference = _storage.ref().child(path);
      await reference.putData(
        bytes,
        SettableMetadata(contentType: contentType),
      );
      return await reference.getDownloadURL();
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> deleteImageByUrl(String downloadUrl) async {
    try {
      await _storage.refFromURL(downloadUrl).delete();
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> deleteImageByPath(String storagePath) async {
    try {
      await _storage.ref().child(storagePath).delete();
    } catch (error) {
      throw AppException.fromError(error);
    }
  }
}
