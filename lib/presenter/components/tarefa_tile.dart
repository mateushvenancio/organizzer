import 'package:flutter/material.dart';
import 'package:organizzer/entities/tarefa_entity.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';

class TarefaTile extends StatelessWidget {
  final TarefaEntity tarefa;
  const TarefaTile({super.key, required this.tarefa});

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
    return Row(
      children: [
        Container(
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
        SizedBox(width: kMainPadding),
        Expanded(
          child: Text(
            tarefa.nome,
            style: TextStyle(decoration: _getLineThrough),
          ),
        ),
        SizedBox(width: kMainPadding),
        Text('Abr 07'),
      ],
    );
  }
}
