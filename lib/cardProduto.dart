import 'package:flutter/material.dart';
import 'package:adopt_place/produto.dart';
import 'package:adopt_place/telaProduto.dart';

class CardProduto extends StatelessWidget {
  final Produto produto;
  const CardProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaProduto(produtoId: produto.id),
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: produto.imagem.isEmpty
                  ? const Icon(Icons.pets, size: 48)
                  : Image.network(
                      produto.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 48),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      produto.preco,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}