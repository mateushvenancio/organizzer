import 'package:organizzer/core/converters/compra_json_conversor.dart';
import 'package:organizzer/core/dto/create_compra_dto.dart';
import 'package:organizzer/core/dto/edit_compra_dto.dart';
import 'package:organizzer/entities/compra_entity.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteComprasRepository implements IComprasRepository {
  final _conversor = CompraJsonConversor();
  Database? _db;

  Future<Database> _getDb() async {
    return _db ??= await openDatabase('${await getDatabasesPath()}/organizzer_db', version: 1, onCreate: (db, _) async {
      await db.execute(_createTableQuery);
    });
  }

  @override
  Future<CompraEntity> createCompra(CreateCompraDto dto) async {
    final db = await _getDb();
    final id = await db.rawInsert(
      _insertQuery,
      [dto.nome, dto.preco, dto.quantidade, false, DateTime.now().toString()],
    );
    final ultimo = (await db.rawQuery(_queryById, [id])).first;
    return _conversor.from({
      ...ultimo,
      'id': ultimo['id'].toString(),
      'done': ultimo['done'] == '1' ? true : false,
    });
  }

  @override
  Future<void> deleteCompra(String id) async {
    final db = await _getDb();
    await db.rawDelete(_deleteQuery, [id]);
  }

  @override
  Future<void> deleteTodos() async {
    final db = await _getDb();
    await db.rawDelete(_deleteAllQuery);
  }

  @override
  Future<CompraEntity> editCompra(EditCompraDto dto) async {
    final db = await _getDb();
    final result = (await db.rawQuery(_queryById, [dto.id])).first;
    final compra = _conversor.from({
      ...result,
      'id': result['id'].toString(),
      'done': result['done'] == '1' ? true : false,
    });
    final newDto = compra.copyWith(
      done: dto.done,
      nome: dto.nome,
      preco: dto.preco,
      quantidade: dto.quantidade,
    );

    await db.rawUpdate(
      _updateQuery,
      [newDto.nome, newDto.preco, newDto.quantidade, newDto.done, newDto.id],
    );

    return newDto;
  }

  @override
  Future<List<CompraEntity>> getCompras() async {
    final db = await _getDb();
    final result = await db.rawQuery(_queryAll);
    return result.map((e) {
      final value = {
        ...e,
        'id': e['id'].toString(),
        'done': e['done'] == '1' ? true : false,
      };
      return _conversor.from(value);
    }).toList();
  }
}

const _createTableQuery = '''CREATE TABLE Compras
(
  id INTEGER PRIMARY KEY,
  nome TEXT,
  preco REAL,
  quantidade INTEGER,
  done INTEGER,
  createdAt TEXT
)
''';

const _insertQuery = '''INSERT INTO Compras(
  nome, preco, quantidade, done, createdAt
) VALUES (?, ?, ?, ?, ?)
''';

const _queryAll = 'SELECT * FROM Compras';

const _queryById = 'SELECT * FROM Compras WHERE id = ?';

const _updateQuery = 'UPDATE Compras SET nome = ?, preco = ?, quantidade = ?, done = ? WHERE id = ?';

const _deleteQuery = 'DELETE FROM Compras WHERE id = ?';

const _deleteAllQuery = 'DELETE FROM Compras';
