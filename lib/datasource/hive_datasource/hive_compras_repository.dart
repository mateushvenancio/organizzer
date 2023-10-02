import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';

const _comprasKey = 'compras_box_key';

class HiveComprasRepository implements IComprasRepository {
  final initBox = Completer();
  late final Box<List> box;

  HiveComprasRepository() {
    _initialize();
  }

  _initialize() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    box = await Hive.openBox<List>(
      'compras_box',
      path: path.join(directory.path, 'compras_box'),
    );
    initBox.complete();
  }

  @override
  Future<CompraEntity> createCompra(CreateCompraDto dto) async {
    await initBox.future;
    final compra = CompraEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
      createdAt: DateTime.now(),
      categoria: dto.categoria,
    );
    final result = box.get(_comprasKey, defaultValue: [])!;
    result.add(compra.toMap());
    await box.put(_comprasKey, result);
    return compra;
  }

  @override
  Future<void> deleteCompra(String id) async {
    await initBox.future;
    final compras = await getCompras();

    compras.removeWhere((e) => e.id == id);
  }

  @override
  Future<void> deleteTodos() async {
    await initBox.future;
    await box.put(_comprasKey, []);
  }

  @override
  Future<CompraEntity> editCompra(EditCompraDto dto) async {
    await initBox.future;
    final compras = await getCompras();
    final compra = compras.where((e) => e.id == dto.id).first;
    final index = compras.indexWhere((e) => e.id == dto.id);

    final novaCompra = compra.copyWith(
      done: dto.done,
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
      categoria: dto.categoria,
    );

    compras[index] = novaCompra;
    await box.put(_comprasKey, compras.map((e) => e.toMap()).toList());

    return novaCompra;
  }

  @override
  Future<List<CompraEntity>> getCompras() async {
    await initBox.future;
    final result = box.get(_comprasKey) ?? [];
    return result.map((e) {
      return CompraEntity.fromMap(e);
    }).toList();
  }
}
