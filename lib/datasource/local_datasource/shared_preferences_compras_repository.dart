import 'dart:convert';

import 'package:organizzer/core/converters/compra_json_conversor.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';
import 'package:organizzer/utils/generate_uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesComprasRepository implements IComprasRepository {
  final compraConversor = CompraJsonConversor();
  final comprasKey = 'COMPRAS_DB';

  _saveCompras(List<CompraEntity> compras) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> comprasJson = compras.map((e) {
      return jsonEncode(compraConversor.to(e));
    }).toList();
    await prefs.setStringList(comprasKey, comprasJson);
  }

  @override
  Future<CompraEntity> createCompra(CreateCompraDto dto) async {
    final novaCompra = CompraEntity(
      id: generateUuid(),
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
      done: false,
      createdAt: DateTime.now(),
    );

    final compras = await getCompras();
    compras.add(novaCompra);
    await _saveCompras(compras);
    return novaCompra;
  }

  @override
  Future<void> deleteCompra(String id) async {
    final compras = await getCompras();
    compras.removeWhere((e) => e.id == id);
    await _saveCompras(compras);
  }

  @override
  Future<CompraEntity> editCompra(EditCompraDto dto) async {
    final compras = await getCompras();
    final index = compras.indexWhere((e) => e.id == dto.id);
    compras[index] = compras[index].copyWith(
      done: dto.done,
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
    );
    await _saveCompras(compras);
    return compras[index];
  }

  @override
  Future<List<CompraEntity>> getCompras() async {
    final prefs = await SharedPreferences.getInstance();
    final compras = prefs.getStringList(comprasKey) ?? [];
    return compras.map((e) {
      final aaa = jsonDecode(e);
      aaa;
      return compraConversor.from(aaa);
    }).toList();
  }

  @override
  Future<void> deleteTodos() async {
    await _saveCompras([]);
  }
}
