import 'dart:js_interop';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'Transaction.dart';
import 'Earn.dart';
import 'Expense.dart';

class DatabaseManager {
  //Create a private constructor
  DatabaseManager._();

  static const databaseName = 'transaction_database.db';
  static final DatabaseManager instance = DatabaseManager._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE Transaction(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, type TEXT, name TEXT, date TEXT, amount DOUBLE)");
        });
  }

  insertTxn(Txn txn) async {
    final db = await database;
    var res;
    if(txn is Earn)
      res = await db.insert(Txn.TABLENAME, earn.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    else
      res = await db.insert(Txn.TABLENAME, Expense.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Txn>> retrieveTxn() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Txn.TABLENAME);

    return List.generate(maps.length, (i) {
      return Txn(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });
  }

  updateTxn(Txn txn) async {
    final db = await database;

    if(type == 'Earn')
      await db.update(Txn.TABLENAME, Earn.toMap(),
        where: 'id = ?',
        whereArgs: [getID()],
        conflictAlgorithm: ConflictAlgorithm.replace);
    else
      await db.update(Txn.TABLENAME, Expense.toMap(),
          where: 'id = ?',
          whereArgs: [todo.id],
          conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteTxn(int id) async {
    var db = await database;
    db.delete(Txn.TABLENAME, where: 'id = ?', whereArgs: [id]);
  }
}
