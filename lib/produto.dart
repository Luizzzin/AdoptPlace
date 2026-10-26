import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  final String id;
  final String nome;
  final String preco;
  final String imagem;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagem,
  });

  factory Produto.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Produto(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
      preco: data['preco'] ?? 'Sem preço',
      imagem: data['imagem'] ?? '',
    );
  }
}