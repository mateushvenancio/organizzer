import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/repositories/i_categorias_repository.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';

class CategoriasController extends ChangeNotifier {
  final ICategoriasRepository categoriasRepository;
  final IComprasRepository comprasRepository;

  CategoriasController(
    this.categoriasRepository,
    this.comprasRepository,
  );

  init() async {
    categorias = await categoriasRepository.getCategorias();
    notifyListeners();
  }

  List<CategoriaEntity> categorias = [];

  createCategoria(CreateCategoriaDto dto) async {
    final result = await categoriasRepository.createCategoria(dto);
    categorias.add(result);
    notifyListeners();
  }

  deleteCategoria(String id) async {
    await categoriasRepository.deleteCategoria(id);
    categorias.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  editCategoria(EditCategoriaDto dto) async {
    final novaCategoria = await categoriasRepository.editCategoria(dto);
    final compras = (await comprasRepository.getCompras()).where((e) {
      return e.categoria.id == dto.id;
    });
    final dtos = compras.map(
      (e) => EditCompraDto(
        id: e.id,
        done: e.done,
        categoria: novaCategoria,
      ),
    );

    for (final editCompraDto in dtos) {
      await comprasRepository.editCompra(editCompraDto);
    }

    await init();
  }
}
