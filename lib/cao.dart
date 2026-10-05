import 'package:cloud_firestore/cloud_firestore.dart';

class Cao {
  final String id;
  final String nome;
  final String idade;
  final String temperamento;
  final String imagem;

  Cao({
    required this.id,
    required this.nome,
    required this.idade,
    required this.temperamento,
    required this.imagem,
  });

  factory Cao.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Cao(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
      idade: data['idade'] ?? 'Sem idade',
      temperamento: data['temperamento'] ?? '',
      imagem: data['imagem'] ?? '',
    );
  }
}