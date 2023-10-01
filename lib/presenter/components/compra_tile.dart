import 'package:flutter/material.dart';
import 'package:organizzer/core/extensions/num_extension.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/resources/colors.dart';

class CompraTile extends StatelessWidget {
  final CompraEntity compra;
  final Function(CompraEntity) onTap;
  final Function(CompraEntity)? onEdit;
  final Future<bool> Function(CompraEntity)? onDelete;
  final bool _collapsed;

  const CompraTile({
    super.key,
    required this.compra,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  }) : _collapsed = false;

  const CompraTile.collapsed({
    super.key,
    required this.compra,
    required this.onTap,
    this.onEdit,
    this.onDelete,
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

  TextDecoration? get _getDecoration {
    if (!compra.done) return null;
    return TextDecoration.lineThrough;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(compra.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return (await onDelete?.call(compra)) ?? false;
      },
      child: ListTile(
        contentPadding: _collapsed ? EdgeInsets.zero : null,
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getColor,
            border: Border.all(
              color: _getBorderColor,
            ),
          ),
          child: _getIcon,
        ),
        onLongPress: () => onEdit?.call(compra),
        // trailing: Text(DateFormatter().miniDate(compra.createdAt)),
        // trailing: _collapsed
        //     ? null
        //     : Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           IconButton(
        //             onPressed: () => onEdit?.call(compra),
        //             icon: Icon(Icons.edit_outlined),
        //           ),
        //           IconButton(
        //             onPressed: () => onDelete?.call(compra),
        //             icon: Icon(Icons.delete_outline),
        //           ),
        //         ],
        //       ),
        title: Text(
          '${compra.nome} - R\$ ${(compra.quantidade * compra.preco).toPrice()}',
          style: TextStyle(
            decoration: _getDecoration,
          ),
        ),
        subtitle: Text('${compra.quantidade}× R\$ ${compra.preco.toPrice()}'),
        onTap: () => onTap(compra),
        // onLongPress: () => onLongTap?.call(compra),
      ),
    );
  }
}
