import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

// データベースの情報は端末上で「.db」という拡張子のファイルに格納されます。
class HistoryViewModel {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        password TEXT,
        sizeNumber INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime'))
      )
      """);
    debugPrint("historyPageのcreateTables");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'history.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future deleteTable() async {
    var databasesPath = await sql.getDatabasesPath();
    String path = p.join(databasesPath, 'history.db');
    await sql.deleteDatabase(path);
    debugPrint('delete');
  }

  static Future<int> createItem(String password, int sizeNumber) async {
    final db = await HistoryViewModel.db();

    final data = {'password': password, 'sizeNumber': sizeNumber};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getHistorys() async {
    final db = await HistoryViewModel.db();
    return db.query('items', orderBy: "id DESC");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await HistoryViewModel.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String password, int sizeNumber) async {
    final db = await HistoryViewModel.db();

    final data = {
      'password': password,
      'sizeNumber': sizeNumber,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await HistoryViewModel.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAll() async {
    final db = await HistoryViewModel.db();
    try {
      await db.delete("items");
    } catch (err) {
      debugPrint("Something went wrong when deleting all item: $err");
    }
  }
}
