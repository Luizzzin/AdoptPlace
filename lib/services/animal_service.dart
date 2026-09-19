import 'package:adopt_place/exceptions/app_exception.dart';
import 'package:adopt_place/models/animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Comunicação de animais exclusivamente com a coleção /animals.
class AnimalService {
  AnimalService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _animals =>
      _firestore.collection('animals');

  Future<Animal> createAnimal(Animal animal) async {
    try {
      final reference = _animals.doc();
      final data = animal.toMap()
        ..['createdAt'] = FieldValue.serverTimestamp()
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await reference.set(data);
      return animal.copyWith(id: reference.id);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<Animal> getAnimal(String animalId) async {
    try {
      final snapshot = await _animals.doc(animalId).get();
      if (!snapshot.exists || snapshot.data() == null) {
        throw AppException.notFound('Animal');
      }
      return Animal.fromMap(snapshot.id, snapshot.data()!);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<List<Animal>> listAnimals({
    String? species,
    AnimalSize? size,
    AnimalSex? sex,
    String? city,
    String? state,
    AnimalStatus? status,
    bool newestFirst = true,
    int? limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _animals;
      if (species != null) query = query.where('species', isEqualTo: species);
      if (size != null) query = query.where('size', isEqualTo: size.name);
      if (sex != null) query = query.where('sex', isEqualTo: sex.name);
      if (city != null) query = query.where('city', isEqualTo: city);
      if (state != null) query = query.where('state', isEqualTo: state);
      if (status != null) query = query.where('status', isEqualTo: status.name);

      query = query.orderBy('createdAt', descending: newestFirst);
      if (startAfterDocument != null) {
        query = query.startAfterDocument(startAfterDocument);
      }
      if (limit != null) query = query.limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map((document) => Animal.fromMap(document.id, document.data()))
          .toList(growable: false);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> updateAnimal(Animal animal) async {
    if (animal.id.isEmpty) {
      throw const AppException(
        code: 'invalid-animal-id',
        message: 'O animal precisa possuir um identificador válido.',
      );
    }

    try {
      final data = animal.toMap()
        ..remove('createdAt')
        ..remove('createdBy')
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await _animals.doc(animal.id).update(data);
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> updateAnimalStatus(String animalId, AnimalStatus status) async {
    try {
      await _animals.doc(animalId).update({
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      throw AppException.fromError(error);
    }
  }

  Future<void> deactivateAnimal(String animalId) =>
      updateAnimalStatus(animalId, AnimalStatus.inactive);

  Future<void> deleteAnimal(String animalId) async {
    try {
      await _animals.doc(animalId).delete();
    } catch (error) {
      throw AppException.fromError(error);
    }
  }
}
