import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  final String id;
  final String nome;
  final String preco;
  final String imagem;
  final String descricao;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagem,
    required this.descricao,
  });

  factory Produto.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Produto(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
      preco: data['preco'] ?? 'Sem preço',
      imagem: data['imagem'] ?? '',
      descricao: data['descricao'] ?? 'Sem Descrição!',
    );
  }
}