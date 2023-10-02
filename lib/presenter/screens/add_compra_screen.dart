import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';
import 'package:organizzer/presenter/components/primary_button.dart';
import 'package:organizzer/presenter/controllers/categorias_controller.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';

class CompraFormScreen extends StatefulWidget {
  final CompraEntity? compra;

  const CompraFormScreen({
    super.key,
    this.compra,
  });

  @override
  State<CompraFormScreen> createState() => _CompraFormScreenState();
}

class _CompraFormScreenState extends State<CompraFormScreen> {
  final tituloController = TextEditingController();
  final precoController = TextEditingController();

  final tituloNode = FocusNode();
  final precoNode = FocusNode();

  String? tituloError;
  String? precoError;
  CategoriaEntity? categoria;

  int quantidade = 1;

  returnCompra() {
    final preco = num.tryParse(precoController.text.replaceAll(',', '.'));

    if (tituloController.text.isEmpty) {
      return setState(() {
        tituloError = 'Digite um nome para a compra';
      });
    }

    // if (preco != null && preco > 0) {
    //   return setState(() {
    //     tituloError = 'Preço deve ser válido e maior que 0';
    //   });
    // }

    if (categoria == null) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selecione uma categoria')));
    }

    if (widget.compra == null) {
      final compra = CreateCompraDto(
        nome: tituloController.text,
        quantidade: quantidade,
        preco: (preco ?? 0) * 1.0,
        categoria: categoria!,
      );
      context.read<CompraController>().addCompra(compra);
      // widget.onCreate(
      // CreateCompraDto(
      //   nome: tituloController.text,
      //   quantidade: quantidade,
      //   preco: preco ?? 0,
      //   categoria: categoria!,
      // ),
      // );
    } else {
      final compra = EditCompraDto(
        id: widget.compra!.id,
        done: widget.compra!.done,
        nome: tituloController.text,
        preco: (preco ?? 0) * 1.0,
        quantidade: quantidade,
      );
      context.read<CompraController>().editCompra(compra);
      // widget.onEdit?.call(
      //   EditCompraDto(
      //     id: widget.compra!.id,
      //     done: widget.compra!.done,
      //     nome: tituloController.text,
      //     preco: preco ?? 0,
      //     quantidade: quantidade,
      //   ),
      // );
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
    return Scaffold(
      appBar: MainAppBar(
        title: widget.compra == null ? 'Novo Item' : 'Editar Item',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // NumberPicker(
            //   minValue: 1,
            //   maxValue: 50,
            //   onChanged: (value) {
            //     setState(() {
            //       quantidade = value;
            //     });
            //   },
            //   value: quantidade,
            //   axis: Axis.horizontal,
            //   infiniteLoop: false,
            //   haptics: true,
            // ),
            SizedBox(height: 8),
            _NumberPicker(
              max: 50,
              selected: quantidade,
              onSelect: (value) {
                setState(() {
                  quantidade = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('Selecione a categoria:'),
            ),
            ListView(
              shrinkWrap: true,
              children: context.read<CategoriasController>().categorias.map((e) {
                return RadioListTile<CategoriaEntity>(
                  contentPadding: EdgeInsets.all(0),
                  value: e,
                  groupValue: categoria,
                  onChanged: (value) {
                    setState(() {
                      categoria = value;
                    });
                  },
                  activeColor: AppColors.greySecondary,
                  title: Row(
                    children: [
                      Icon(
                        Icons.sell,
                        color: Color(e.cor),
                      ),
                      SizedBox(width: 16),
                      Text(e.nome),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(width: 16),
          Expanded(
            child: PrimaryButton(
              onTap: () => context.pop(),
              text: 'CANCELAR',
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: PrimaryButton(
              onTap: () => returnCompra(),
              text: 'OK',
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _NumberPicker extends StatelessWidget {
  final int selected;
  final Function(int) onSelect;
  final int max;

  const _NumberPicker({
    required this.selected,
    required this.onSelect,
    this.max = 50,
  });

  BorderRadiusGeometry? getBorderRadius(int index) {
    if (index == 1) {
      return BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      );
    }

    if (index == max) {
      return BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }

    return null;
  }

  BoxBorder? getBorder(int index) {
    if (index == 1) {
      return Border.all(
        color: Colors.grey,
      );
    }

    if (index == max) {
      return Border.all(
        color: Colors.grey,
      );
    }

    return Border(
      top: BorderSide(
        color: Colors.grey,
      ),
      bottom: BorderSide(
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        itemCount: max,
        // separatorBuilder: (context, index) => Container(width: 1),
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 1,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selectedIndex = index + 1;
          return AspectRatio(
            aspectRatio: 1,
            child: InkWell(
              onTap: () => onSelect(selectedIndex),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: getBorderRadius(selectedIndex),
                  border: getBorder(selectedIndex),
                  color: selected == selectedIndex ? AppColors.primaryColor : Colors.white,
                ),
                child: Text(
                  '$selectedIndex',
                  style: TextStyle(
                    fontSize: 20,
                    color: selected == selectedIndex ? Colors.white : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
