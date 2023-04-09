import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';

class AddCompraDialog extends StatefulWidget {
  final Function(CreateCompraDto?) onSelect;
  const AddCompraDialog({super.key, required this.onSelect});

  @override
  State<AddCompraDialog> createState() => _AddCompraDialogState();
}

class _AddCompraDialogState extends State<AddCompraDialog> {
  final controller = TextEditingController();
  String? error;

  returnCompra() {
    if (controller.text.isEmpty) {
      return setState(() {
        error = 'Digite um nome para a compra';
      });
    }
    widget.onSelect(CreateCompraDto(nome: controller.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nova Compra'),
      content: MainTextField(
        hint: 'Título da compra',
        controller: controller,
        errorText: error,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => returnCompra(),
          child: Text(
            'Adicionar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
