import 'package:flutter/material.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/resources/colors.dart';

class CompraTile extends StatelessWidget {
  final CompraEntity compra;
  final Function(CompraEntity) onTap;
  final bool _collapsed;

  const CompraTile({
    super.key,
    required this.compra,
    required this.onTap,
  }) : _collapsed = false;

  const CompraTile.collapsed({
    super.key,
    required this.compra,
    required this.onTap,
  }) : _collapsed = true;

  Widget get _getIcon {
    if (compra.done) {
      return Icon(Icons.check, color: Colors.white);
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
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
    return ListTile(
      contentPadding: _collapsed ? EdgeInsets.zero : null,
      leading: Container(
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
      title: Text(compra.nome),
      onTap: () => onTap(compra),
    );
  }
}
