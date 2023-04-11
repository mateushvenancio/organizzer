import 'package:flutter/material.dart';
import 'package:organizzer/core/formatters/date_formatter.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/resources/colors.dart';

class TarefaTile extends StatelessWidget {
  final TarefaEntity tarefa;
  final Function(TarefaEntity) onTap;
  final Function(TarefaEntity)? onLongTap;
  final bool _collapsed;

  const TarefaTile({
    super.key,
    required this.tarefa,
    required this.onTap,
    this.onLongTap,
  }) : _collapsed = false;

  Widget get _getIcon {
    if (tarefa.done) {
      return Icon(Icons.check, color: Colors.white);
    }

    return Container();
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
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getColor,
          border: Border.all(
            color: _getBorderColor,
          ),
        ),
        child: _getIcon,
      ),
      trailing: Text(DateFormatter().miniDate(tarefa.createdAt)),
      title: Text(
        tarefa.nome,
        style: TextStyle(
          decoration: _getLineThrough,
        ),
      ),
      onTap: () => onTap(tarefa),
      onLongPress: () => onLongTap?.call(tarefa),
    );
  }
}
