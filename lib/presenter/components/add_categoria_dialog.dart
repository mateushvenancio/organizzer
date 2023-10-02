import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:organizzer/resources/colors.dart';

class AddCategoriaDialog extends StatefulWidget {
  final CategoriaEntity? categoria;
  final Function(CreateCategoriaDto) onCreate;
  final Function(EditCategoriaDto)? onEdit;

  const AddCategoriaDialog({
    super.key,
    this.categoria,
    required this.onCreate,
    this.onEdit,
  });

  @override
  State<AddCategoriaDialog> createState() => _AddCategoriaDialogState();
}

class _AddCategoriaDialogState extends State<AddCategoriaDialog> {
  final _nomeController = TextEditingController();
  String? nomeError;
  Color _cor = AppColors.primaryColor;

  returnCategoria() {
    if (_nomeController.text.isEmpty) {
      return setState(() {
        nomeError = 'Digite um nome válido';
      });
    }

    if (widget.categoria == null) {
      widget.onCreate(CreateCategoriaDto(
        nome: _nomeController.text,
        cor: _cor.value,
      ));
    } else {
      widget.onEdit?.call(
        EditCategoriaDto(
          id: widget.categoria!.id,
          name: _nomeController.text,
          cor: _cor.value,
        ),
      );
    }

    context.pop();
  }

  @override
  void initState() {
    final old = widget.categoria;
    if (old != null) {
      _nomeController.text = old.nome;
      _cor = Color(old.cor);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.categoria == null ? 'Criar categoria' : 'Editar categoria'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTextField(
            controller: _nomeController,
            label: 'Nome da categoria',
            hint: 'Ex: Supermercado',
            errorText: nomeError,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text('Selecione a cor da categoria:'),
          ),
          ColorPicker(
            pickerColor: _cor,
            onColorChanged: (value) {
              setState(() {
                _cor = value;
              });
            },
            enableAlpha: false,
            pickerAreaHeightPercent: 0.25,
            labelTypes: const [],
          ),
          // Flexible(
          //   fit: FlexFit.loose,
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints(
          //       minHeight: 250,
          //     ),
          //     child: MaterialPicker(
          //       pickerColor: _cor,
          //       onColorChanged: (value) {
          //         setState(() {
          //           _cor = value;
          //         });
          //       },
          //     ),
          //   ),
          // ),

          // HueRingPicker(
          //   pickerColor: _cor,
          //   onColorChanged: (value) {
          //     setState(() {
          //       _cor = value;
          //     });
          //   },
          //   enableAlpha: false,
          //   displayThumbColor: true,
          //   colorPickerHeight: 150,
          //   hueRingStrokeWidth: 15,
          // ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: AppColors.primaryVariant,
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              AppColors.primaryColor,
            ),
          ),
          onPressed: () => returnCategoria(),
          child: Text(
            'Adicionar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        // TextButton(
        //   onPressed: () => returnCategoria(),
        //   child: Text(
        //     'Adicionar',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
