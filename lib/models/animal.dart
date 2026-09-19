import 'package:cloud_firestore/cloud_firestore.dart';

enum AnimalStatus { available, pending, adopted, inactive }

enum AnimalSize { small, medium, large }

enum AnimalSex { female, male, unknown }

class Animal {
  const Animal({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.species,
    required this.size,
    required this.sex,
    required this.age,
    required this.description,
    required this.city,
    required this.state,
    required this.photoUrls,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.breed,
  });

  final String id;
  final String createdBy;
  final String name;
  final String species;
  final String? breed;
  final AnimalSize size;
  final AnimalSex sex;
  final int age;
  final String description;
  final String city;
  final String state;
  final List<String> photoUrls;
  final AnimalStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() => {
    'createdBy': createdBy,
    'name': name,
    'species': species,
    'breed': breed,
    'size': size.name,
    'sex': sex.name,
    'age': age,
    'description': description,
    'city': city,
    'state': state,
    'photoUrls': photoUrls,
    'status': status.name,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  factory Animal.fromMap(String id, Map<String, dynamic> map) => Animal(
    id: id,
    createdBy: map['createdBy'] as String? ?? '',
    name: map['name'] as String? ?? '',
    species: map['species'] as String? ?? '',
    breed: map['breed'] as String?,
    size: _enumValue(AnimalSize.values, map['size'], AnimalSize.medium),
    sex: _enumValue(AnimalSex.values, map['sex'], AnimalSex.unknown),
    age: map['age'] as int? ?? 0,
    description: map['description'] as String? ?? '',
    city: map['city'] as String? ?? '',
    state: map['state'] as String? ?? '',
    photoUrls: List<String>.from(map['photoUrls'] as List? ?? const []),
    status: _enumValue(
      AnimalStatus.values,
      map['status'],
      AnimalStatus.available,
    ),
    createdAt: _dateFrom(map['createdAt']),
    updatedAt: _dateFrom(map['updatedAt']),
  );

  Animal copyWith({
    String? id,
    String? createdBy,
    String? name,
    String? species,
    String? breed,
    AnimalSize? size,
    AnimalSex? sex,
    int? age,
    String? description,
    String? city,
    String? state,
    List<String>? photoUrls,
    AnimalStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Animal(
    id: id ?? this.id,
    createdBy: createdBy ?? this.createdBy,
    name: name ?? this.name,
    species: species ?? this.species,
    breed: breed ?? this.breed,
    size: size ?? this.size,
    sex: sex ?? this.sex,
    age: age ?? this.age,
    description: description ?? this.description,
    city: city ?? this.city,
    state: state ?? this.state,
    photoUrls: photoUrls ?? this.photoUrls,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  static T _enumValue<T extends Enum>(
    List<T> values,
    dynamic value,
    T fallback,
  ) {
    for (final item in values) {
      if (item.name == value) return item;
    }
    return fallback;
  }

  static DateTime _dateFrom(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
