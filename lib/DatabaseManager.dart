import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

import 'Transaction.dart';
import 'Earn.dart';
import 'Expense.dart';

class DatabaseManager {
  //Create a private constructor
  //DatabaseManager._();

  String databaseName = 'transaction.db';
  String tableName = 'Trnsctn';

  Future destroyDatabase() async {
    String path =  join(await getDatabasesPath(), databaseName);
    await deleteDatabase(path);
  }

  Future createSamples() async {
    destroyDatabase();
    var db = await initializeDatabase();
    await db.transaction((tren) async {
      int id = await tren.rawInsert('''
      INSERT INTO $tableName (id, name, price, date, type) VALUES
      (8040942186, "testing", 420.0, "2023-12-2", "Earn"),
      (5151532969, "testing", 420.0, "2023-12-2", "Expense"),
      (4217387442, "testing", 420.0, "2023-12-2", "Earn"),
      (6318232871, "testing", 420.0, "2023-12-2", "Earn")
      ''');
      // (3172612479, "testing", 420.0, "2023-12-2", "Expense"),
      // (5056126351, "testing", 420.0, "2023-12-2", "Expense"),
      // (9514090978, "testing", 420.0, "2023-12-2", "Earn"),
      // (2727647166, "testing", 420.0, "2023-12-2", "Earn"),
      // (7990108944, "testing", 420.0, "2023-12-2", "Expense"),
      // (1234236845, "testing", 420.0, "2023-12-2", "Earn"),
      // (1063620030, "testing", 420.0, "2023-12-2", "Earn"),
      // (2884328870, "testing", 420.0, "2023-12-2", "Earn"),
      // (8059116824, "testing", 420.0, "2023-12-2", "Expense"),
      // (9182066726, "testing", 420.0, "2023-12-2", "Expense"),
      // (6476168608, "testing", 420.0, "2023-12-2", "Expense")
      // ''');
    });
  }

  Future<Database> initializeDatabase() async {
    print('CREATING DATABASE');
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Trnsctn (id INTEGER PRIMARY KEY, type TEXT, name TEXT, date TEXT, price DOUBLE)');
        });
  }

  Future<Database> getDB() async {
    return openDatabase(databaseName);
  }

  Future<List<Map>> insertTxn(Txn txn) async {
    var db = await initializeDatabase();
    // print('CHECK THIS OUT');
    // print(db);
    var id = await db.insert(tableName, txn.toMap());
    print('THIS IS THE ID AFTER INSERTING THE RECORD:\t${id}');
    return await retrieveTxn();
  }

  Future<List<Map>> retrieveTxn() async {
    var db = await getDB();

    List<Map<String, dynamic>> maps = await db.query(tableName);

    print(maps);
    return maps;
  }

  Future updateTxn(Txn txn) async {
    var db = await getDB();

    await db.update(tableName, txn.toMap(), where: 'id = ?', whereArgs: [txn.toMap()['id']]);
  }

  Future<List<Map>> deleteTxn(int id) async {
    var db = await getDB();
    print(await retrieveTxn());
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    return await retrieveTxn();
  }

  Future<List<Map>> dashBoard() async {
    // createSamples();
    var db = await getDB();

    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT SUM(price) as total, type FROM $tableName GROUP BY type');

    print('DASHBOARD FINDINGS');
    print(maps);
    // destroyDatabase();
    return maps;
  }
}