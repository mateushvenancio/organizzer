import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';

abstract class IComprasRepository {
  Future<List<CompraEntity>> getCompras();
  Future<CompraEntity> createCompra(CreateCompraDto dto);
  Future<CompraEntity> editCompra(EditCompraDto dto);
  Future<void> deleteCompra(String id);
}
