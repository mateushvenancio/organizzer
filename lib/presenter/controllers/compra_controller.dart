import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';

class CompraController extends ChangeNotifier {
  final IComprasRepository repository;
  CompraController(this.repository);

  init() async {
    final result = await repository.getCompras();
    compras = result;
    notifyListeners();
  }

  List<CompraEntity> compras = [];
  List<CompraEntity> get topCompras {
    if (compras.length < 3) return compras;
    return compras.getRange(0, 3).toList();
  }

  double get total {
    return compras.fold<double>(0, (p, e) => p + (e.quantidade * e.preco));
  }

  addCompra(CreateCompraDto value) async {
    final novo = await repository.createCompra(value);
    compras.add(novo);
    notifyListeners();
  }

  editCompra(EditCompraDto value) async {
    final index = compras.indexWhere((e) => e.id == value.id);
    compras[index] = await repository.editCompra(value);
    notifyListeners();
  }

  deleteCompra(CompraEntity value) async {
    final index = compras.indexWhere((e) => e.id == value.id);
    await repository.deleteCompra(value.id);
    compras.removeAt(index);
    notifyListeners();
  }

  deleteTodos() async {
    await repository.deleteTodos();
    compras.clear();
    notifyListeners();
  }
}
