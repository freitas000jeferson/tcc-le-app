import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcc_le_app/core/database/database_helper.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class MessagesRepository {
  final tableName = 'messages';
  final _db = DatabaseHelper.instance;

  Future<Database> getDatabase() async {
    return await _db.db;
  }

  Future<Either<Failure, Message>> save(Message data) async {
    try {
      final database = await getDatabase();
      data.id = await database.insert(tableName, data.toJson());
      return Right(data);
    } catch (e) {
      print("🔴 save $e");
      return Left(DatabaseFailure("Erro ao salvar mensagem"));
    }
  }

  Future<Either<Failure, Message>> update(Message data) async {
    try {
      final database = await getDatabase();
      await database.update(
        tableName,
        data.toJson(),
        where: "${MessageVarNames.id} = ?",
        whereArgs: [data.id],
      );
      return Right(data);
    } catch (e) {
      print("🔴 update $e");
      return Left(DatabaseFailure("Erro ao atualizar mensagem"));
    }
  }

  Future<int?> getNumber() async {
    final database = await getDatabase();
    return Sqflite.firstIntValue(
      await database.rawQuery("SELECT COUNT(*) FROM $tableName"),
    );
  }

  Future<Either<Failure, List<Message>>> findInitial({
    required int page,
    int limit = 30,
  }) async {
    try {
      final database = await getDatabase();
      int offset = (limit * page) - limit;

      List<Map<String, dynamic>> result = await database.query(
        tableName,
        limit: limit,
        offset: offset,
        orderBy: "${MessageVarNames.userDate} DESC, ${MessageVarNames.id} DESC",
      );
      return Right(result.map((json) => Message.fromJson(json)).toList());
    } catch (e) {
      print("🔴 findInitial $e");
      return Left(DatabaseFailure("Erro ao buscar mensagens"));
    }
  }

  Future<Either<Failure, List<Message>>> findOlder({
    required int lastTimestamp,
    required int lastId,
    int limit = 30,
  }) async {
    try {
      final database = await getDatabase();

      List<Map<String, dynamic>> result = await database.rawQuery(
        '''
      SELECT * FROM $tableName
      WHERE (${MessageVarNames.userDate} < ?) OR (${MessageVarNames.userDate} = ? AND ${MessageVarNames.id} < ?)
      ORDER BY ${MessageVarNames.userDate} DESC, ${MessageVarNames.id} DESC
      LIMIT ?
    ''',
        [lastTimestamp, lastTimestamp, lastId, limit],
      );

      return Right(result.map((json) => Message.fromJson(json)).toList());
    } catch (e) {
      print("🔴 findOlder $e");

      return Left(DatabaseFailure("Erro ao buscar mensagens"));
    }
  }
}
