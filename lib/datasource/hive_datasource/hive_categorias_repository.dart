import 'dart:async';

import 'package:hive/hive.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/repositories/i_categorias_repository.dart';

// const _categoriasKey = 'categorias_box_key';

typedef Categorias = List<Map<String, dynamic>>;

class HiveCategoriasRepository implements ICategoriasRepository {
  final initBox = Completer();
  late final Box<Categorias> box;

  HiveCategoriasRepository() {
    _initialize();
  }

  _initialize() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    box = await Hive.openBox<Categorias>(
      'categorias_box',
      path: path.join(directory.path, 'categorias_box'),
    );
    initBox.complete();
  }

  @override
  Future<CategoriaEntity> createCategoria(CreateCategoriaDto dto) async {
    await initBox.future;
    return CategoriaEntity(
      id: DateTime.now().toString(),
      nome: dto.nome ?? '',
      cor: dto.cor ?? 0,
    );
  }

  @override
  Future<void> deleteCategoria(String id) async {}

  @override
  Future<List<CategoriaEntity>> getCategorias() async {
    return [];
  }

  @override
  Future<CategoriaEntity> editCategoria(EditCategoriaDto dto) {
    throw UnimplementedError();
  }
}
