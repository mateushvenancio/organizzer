import 'package:flutter/material.dart';
import 'package:organizzer/entities/compra_entity.dart';

class CompraController extends ChangeNotifier {
  List<CompraEntity> compras = [
    CompraEntity(nome: 'Amaciante', createdAt: DateTime.now(), done: true, descricao: 'De 2L'),
    CompraEntity(nome: 'Sabão em pó', createdAt: DateTime.now(), done: false, descricao: 'De 2L'),
    CompraEntity(nome: 'Chocolate', createdAt: DateTime.now(), done: true),
    CompraEntity(nome: 'Coca cola', createdAt: DateTime.now(), done: false),
    CompraEntity(nome: 'Batata frita', createdAt: DateTime.now(), done: true),
  ];

  editCompra(CompraEntity value) {
    final index = compras.indexWhere((e) => e.id == value.id);
    final compra = compras[index];
    compras[index] = compra.copyWith(done: !compra.done);
    notifyListeners();
  }
}
