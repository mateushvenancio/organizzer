import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:organizzer/core/dto/create_tarefa_dto.dart';
import 'package:organizzer/presenter/components/main_text_field.dart';

class AddTarefaDialog extends StatefulWidget {
  final Function(CreateTarefaDto) onSelect;
  const AddTarefaDialog({super.key, required this.onSelect});

  @override
  State<AddTarefaDialog> createState() => _AddTarefaDialogState();
}

class _AddTarefaDialogState extends State<AddTarefaDialog> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? error;

  _returnTarefa() {
    if (controller.text.isEmpty) {
      return setState(() {
        error = 'Digite um nome para a tarefa';
      });
    }
    widget.onSelect(CreateTarefaDto(controller.text));
    context.pop();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nova tarefa'),
      content: MainTextField(
        controller: controller,
        focusNode: focusNode,
        errorText: error,
        onEnter: () => _returnTarefa(),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _returnTarefa(),
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
