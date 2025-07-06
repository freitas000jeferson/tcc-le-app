import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcc_le_app/core/database/database_helper.dart';
import 'package:tcc_le_app/core/database/tables/message.dart';
import 'package:tcc_le_app/core/utils/failures.dart';

class MessagesRepository {
  final tableName = 'messages';
  final db = DatabaseHelper.instance;

  Future<Database> getDatabase() async {
    return await db.db;
  }

  Future<Either<Failure, Message>> save(Message data) async {
    try {
      final database = await getDatabase();
      data.id = await database.insert(tableName, data.toJson());
      return Right(data);
    } catch (e) {
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
      return Left(DatabaseFailure("Erro ao atualizar mensagem"));
    }
  }

  Future<int?> getNumber() async {
    final database = await getDatabase();
    return Sqflite.firstIntValue(
      await database.rawQuery("SELECT COUNT(*) FROM $tableName"),
    );
  }

  Future<Either<Failure, List<Message>>> findPaginated({
    required int page,
    int size = 30,
  }) async {
    try {
      final database = await getDatabase();
      int offset = (size * page) - size;

      List<Map<String, dynamic>> result = await database.query(
        tableName,
        limit: size,
        offset: offset,
        orderBy: "${MessageVarNames.userDate} DESC",
      );
      return Right(result.map((json) => Message.fromJson(json)).toList());
    } catch (e) {
      return Left(DatabaseFailure("Erro ao buscar mensagens"));
    }
  }
}
