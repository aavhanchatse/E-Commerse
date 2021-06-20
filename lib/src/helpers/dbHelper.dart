import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'category.db'), version: 1,
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE category(id TEXT PRIMARY KEY, name TEXT, products TEXT)');
    });
  }

   static Future<void> insert(String table, data) async {
    final db = await DBHelper.database();

    // print('data in insert: $data');

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

   static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
