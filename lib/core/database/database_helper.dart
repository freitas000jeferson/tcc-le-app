import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcc_le_app/core/database/migrations/migration01.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;

  DatabaseHelper._init();

  Future<Database> get db async {
    _db ??= await _initDB("app.db");
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    Future.forEach(Migration01.script, (sql) async {
      await db.execute(sql);
    });
  }
}
