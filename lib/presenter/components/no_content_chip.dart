import 'package:flutter/material.dart';

class NoContentChip extends StatelessWidget {
  const NoContentChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.info_outline, size: 16),
        SizedBox(width: 8),
        Text('Sem itens a exibir'),
      ],
    );
  }
}
