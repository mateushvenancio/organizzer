import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:numberpicker/numberpicker.dart';

class AddCompraDialog extends StatefulWidget {
  final Function(CreateCompraDto) onCreate;
  final Function(EditCompraDto)? onEdit;
  final CompraEntity? compra;

  const AddCompraDialog({
    super.key,
    this.onEdit,
    this.compra,
    required this.onCreate,
  });

  @override
  State<AddCompraDialog> createState() => _AddCompraDialogState();
}

class _AddCompraDialogState extends State<AddCompraDialog> {
  final tituloController = TextEditingController();
  final precoController = TextEditingController();

  final tituloNode = FocusNode();
  final precoNode = FocusNode();

  String? tituloError;
  String? precoError;

  int quantidade = 1;

  returnCompra() {
    final preco = double.tryParse(precoController.text.replaceAll(',', '.'));

    if (tituloController.text.isEmpty) {
      return setState(() {
        tituloError = 'Digite um nome para a compra';
      });
    }

    if (widget.compra == null) {
      // widget.onCreate(
      //   CreateCompraDto(
      //     nome: tituloController.text,
      //     quantidade: quantidade,
      //     preco: preco ?? 0,
      //   ),
      // );
    } else {
      widget.onEdit?.call(
        EditCompraDto(
          id: widget.compra!.id,
          done: widget.compra!.done,
          nome: tituloController.text,
          preco: preco ?? 0,
          quantidade: quantidade,
        ),
      );
    }
    context.pop();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.compra != null) {
        tituloController.text = widget.compra!.nome;
        precoController.text = widget.compra!.preco.toString();
        quantidade = widget.compra!.quantidade;
      }
      setState(() {
        tituloNode.requestFocus();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.compra == null ? 'Nova Compra' : 'Editar Compra'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTextField(
            hint: 'Título da compra',
            controller: tituloController,
            errorText: tituloError,
            focusNode: tituloNode,
            onEnter: () {
              precoNode.requestFocus();
            },
          ),
          MainTextField(
            hint: 'Preço',
            controller: precoController,
            focusNode: precoNode,
            errorText: precoError,
            onEnter: () => returnCompra(),
            inputType: TextInputType.numberWithOptions(signed: true, decimal: true),
          ),
          NumberPicker(
            minValue: 1,
            maxValue: 50,
            onChanged: (value) {
              setState(() {
                quantidade = value;
              });
            },
            value: quantidade,
            axis: Axis.horizontal,
            infiniteLoop: true,
            haptics: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
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

class _SelecionarCategoria extends StatelessWidget {
  final Function() onTap;

  const _SelecionarCategoria({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text('Selecionar categoria...'),
          ),
          Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }
}
