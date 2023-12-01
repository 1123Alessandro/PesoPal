import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite_common/sqlite_api.dart';

import 'Transaction.dart';
import 'Earn.dart';
import 'Expense.dart';

class DatabaseManager {

  //Create a private constructor
  // DatabaseManager._();

  String databaseName = 'transaction.db';
  String tableName = 'Trnsctn';
  // Database db;
  // static final DatabaseManager instance = DatabaseManager._();
  /*static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }*/

  Future destroyDatabase() async {
    String path =  join(await getDatabasesPath(), databaseName);
    await deleteDatabase(path);
  }

  Future<Database> initializeDatabase() async {
    print('CREATING DATABASE');
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Trnsctn (id INTEGER PRIMARY KEY, type TEXT, name TEXT, date TEXT, price DOUBLE)');
          // await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
        });
  }

  Future<Database> getDB() async {
    return openDatabase(databaseName);
  }

  Future insertTxn(Txn txn) async {
    var db = await getDB();
    print('CHECK THIS OUT');
    print(db);
    var id = await db.insert(tableName, txn.toMap());
    // await db.transaction((tren) async {
    //   int id = await tren.rawInsert('INSERT INTO Trnsctn(id, name, price, date, type) VALUES ("${txn.getID()}", "${txn.getName()}", ${txn.getPrice()}, "${txn.getDate().toString()}", "${txn.getType()}")');
    // });
    print('THIS IS THE ID AFTER INSERTING THE RECORD:\t${id}');
    /* var res;
    if(txn is Earn)
      res = await db.insert(Txn.TABLENAME, earn.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    else
      res = await db.insert(Txn.TABLENAME, Expense.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    return res; */
  }

  Future<List<Map>> retrieveTxn() async {
    var db = await getDB();

    List<Map<String, dynamic>> maps = await db.query(tableName);

    print(maps);
    return maps;
    // return List.generate(maps.length, (i) {
    //   return Txn(
    //     id: maps[i]['id'],
    //     title: maps[i]['title'],
    //     content: maps[i]['content'],
    //   );
    // });
  }

  Future updateTxn(Txn txn) async {
    var db = await getDB();

    await db.update(tableName, txn.toMap(), where: 'id = ?', whereArgs: txn.toMap()['id']);
    // if(type == 'Earn')
    //   await db.update(Txn.TABLENAME, Earn.toMap(),
    //     where: 'id = ?',
    //     whereArgs: [getID()],
    //     conflictAlgorithm: ConflictAlgorithm.replace);
    // else
    //   await db.update(Txn.TABLENAME, Expense.toMap(),
    //       where: 'id = ?',
    //       whereArgs: [todo.id],
    //       conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteTxn(int id) async {
    var db = await getDB();
    db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}