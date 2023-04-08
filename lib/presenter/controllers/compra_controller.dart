import 'package:flutter/material.dart';
import 'package:organizzer/entities/compra_entity.dart';

class CompraController extends ChangeNotifier {
  List<CompraEntity> compras = [];

  addCompra(CompraEntity value) {
    compras.add(value);
    notifyListeners();
  }

  editCompra(CompraEntity value) {
    final index = compras.indexWhere((e) => e.id == value.id);
    final compra = compras[index];
    compras[index] = compra.copyWith(done: !compra.done);
    notifyListeners();
  }
}
