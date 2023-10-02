import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:organizzer/entities/categoria_entity.dart';

abstract class ICategoriasRepository {
  Future<List<CategoriaEntity>> getCategorias();
  Future<CategoriaEntity> createCategoria(CreateCategoriaDto dto);
  Future<void> deleteCategoria(String id);
  Future<CategoriaEntity> editCategoria(EditCategoriaDto dto);
}
