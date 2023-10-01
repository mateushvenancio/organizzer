import 'package:flutter/material.dart';
import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/repositories/i_categorias_repository.dart';

class CategoriasController extends ChangeNotifier {
  final ICategoriasRepository categoriasRepository;
  CategoriasController(this.categoriasRepository);

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
    await categoriasRepository.editCategoria(dto);
    await init();
  }
}
