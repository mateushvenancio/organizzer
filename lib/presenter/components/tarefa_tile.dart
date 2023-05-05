import 'package:flutter/material.dart';
import 'package:organizzer/core/formatters/date_formatter.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/resources/colors.dart';

class TarefaTile extends StatelessWidget {
  final TarefaEntity tarefa;
  final Function(TarefaEntity) onTap;
  final Function(TarefaEntity)? onDelete;
  final bool _collapsed;

  const TarefaTile({
    super.key,
    required this.tarefa,
    required this.onTap,
    this.onDelete,
  }) : _collapsed = false;

  const TarefaTile.collapse({
    super.key,
    required this.tarefa,
    required this.onTap,
    this.onDelete,
  }) : _collapsed = true;

  Widget get _getIcon {
    if (tarefa.done) {
      return Icon(Icons.check, color: Colors.white);
    }

    return Icon(Icons.check, color: Colors.white);
  }

  Color get _getColor {
    if (tarefa.done) {
      return AppColors.green;
    }

    return AppColors.white;
  }

  Color get _getBorderColor {
    if (tarefa.done) {
      return AppColors.green;
    }

    return AppColors.black;
  }

  TextDecoration? get _getLineThrough {
    if (!tarefa.done) return null;
    return TextDecoration.lineThrough;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: _collapsed ? EdgeInsets.zero : null,
      leading: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: double.infinity,
        // width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getColor,
          border: Border.all(
            color: _getBorderColor,
          ),
        ),
        child: _getIcon,
      ),
      // trailing: Text(DateFormatter().miniDate(tarefa.createdAt)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => onDelete?.call(tarefa),
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      title: Text(
        tarefa.nome,
        style: TextStyle(
          decoration: _getLineThrough,
        ),
      ),
      subtitle: Text(DateFormatter().miniDate(tarefa.createdAt)),
      onTap: () => onTap(tarefa),
      // onLongPress: () => onDelete?.call(tarefa),
    );
  }
}
