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

  addCompra(CreateCompraDto value) async {
    final novo = await repository.createCompra(value);
    compras.add(novo);
    notifyListeners();
  }

  editCompra(CompraEntity value) async {
    final index = compras.indexWhere((e) => e.id == value.id);
    compras[index] = await repository.editCompra(
      EditCompraDto(id: value.id, done: !value.done),
    );
    notifyListeners();
  }

  deleteCompra(CompraEntity value) async {
    final index = compras.indexWhere((e) => e.id == value.id);
    await repository.deleteCompra(value.id);
    compras.removeAt(index);
    notifyListeners();
  }
}
