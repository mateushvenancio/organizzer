import 'package:organizzer/core/dto/create_categoria_dto.dart';
import 'package:organizzer/core/dto/edit_categoria_dto.dart';
import 'package:organizzer/datasource/local_datasource/preferences_abstraction.dart';
import 'package:organizzer/entities/categoria_entity.dart';
import 'package:organizzer/repositories/i_categorias_repository.dart';
import 'package:organizzer/utils/generate_uuid.dart';

class SharedPreferencesCategoriasRepository extends PreferencesAbstraction<CategoriaEntity> implements ICategoriasRepository {
  @override
  String get key => 'categorias_key';

  @override
  Future<CategoriaEntity> createCategoria(CreateCategoriaDto dto) async {
    final categoria = CategoriaEntity(
      id: generateUuid(),
      nome: dto.nome ?? 'Sem nome',
      cor: dto.cor ?? 0xff3E00FF,
    );
    await addItem(categoria);
    return categoria;
  }

  @override
  Future<CategoriaEntity> editCategoria(EditCategoriaDto dto) async {
    return editarItem(
      (oldItem) {
        return oldItem.copyWith(
          nome: dto.name,
          cor: dto.cor,
        );
      },
      (e) => e.id == dto.id,
    );
  }

  @override
  Future<void> deleteCategoria(String id) async {
    await deleteWhere((e) => e.id == id);
  }

  @override
  Future<List<CategoriaEntity>> getCategorias() async {
    return await getItems();
  }

  @override
  CategoriaEntity fromMap(Map<String, dynamic> value) => CategoriaEntity.fromMap(value);

  @override
  Map<String, dynamic> toMap(CategoriaEntity value) => value.toMap();
}
