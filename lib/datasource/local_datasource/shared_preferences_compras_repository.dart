import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/datasource/local_datasource/preferences_abstraction.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';
import 'package:organizzer/utils/generate_uuid.dart';

class SharedPreferencesComprasRepository extends PreferencesAbstraction<CompraEntity> implements IComprasRepository {
  @override
  Future<CompraEntity> createCompra(CreateCompraDto dto) async {
    final novaCompra = CompraEntity(
      id: generateUuid(),
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
      done: false,
      createdAt: DateTime.now(),
      categoria: dto.categoria,
    );
    await addItem(novaCompra);
    return novaCompra;
  }

  @override
  Future<void> deleteCompra(String id) async => deleteWhere((value) => value.id == id);

  @override
  Future<CompraEntity> editCompra(EditCompraDto dto) {
    return editarItem(
      (oldItem) {
        return oldItem.copyWith(
          done: dto.done,
          nome: dto.nome,
          preco: dto.preco,
          quantidade: dto.quantidade,
        );
      },
      (value) => value.id == dto.id,
    );
  }
  // final compras = await getCompras();
  // final index = compras.indexWhere((e) => e.id == dto.id);
  // compras[index] = compras[index].copyWith(
  //   done: dto.done,
  //   nome: dto.nome,
  //   preco: dto.preco,
  //   quantidade: dto.quantidade,
  // );
  // await _saveCompras(compras);
  // return compras[index];

  @override
  Future<List<CompraEntity>> getCompras() => getItems();

  @override
  Future<void> deleteTodos() => deleteWhere((_) => true);

  @override
  String get key => 'compras_repository';

  @override
  CompraEntity fromMap(Map<String, dynamic> value) {
    return CompraEntity.fromMap(value);
  }

  @override
  Map<String, dynamic> toMap(CompraEntity value) {
    return value.toMap();
  }
}
