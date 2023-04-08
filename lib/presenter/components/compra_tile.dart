import 'package:flutter/material.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:organizzer/resources/constants.dart';

class CompraTile extends StatelessWidget {
  final CompraEntity compra;
  const CompraTile({super.key, required this.compra});

  Widget get _getIcon {
    if (compra.done) {
      return Icon(Icons.check, color: Colors.white);
    }

    return Container();
  }

  Color get _getColor {
    if (compra.done) {
      return AppColors.green;
    }

    return AppColors.white;
  }

  Color get _getBorderColor {
    if (compra.done) {
      return AppColors.green;
    }

    return AppColors.black;
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
          child: Text(compra.nome),
        ),
        SizedBox(width: kMainPadding),
        Text('Abr 07'),
      ],
    );
  }
}
