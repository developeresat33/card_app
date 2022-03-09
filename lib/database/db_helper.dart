import 'dart:async';

import 'package:card_application/database/db_models/process_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends ChangeNotifier {
  static Database _db;
  int count;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "CardsDB.db");
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Cards (id INTEGER PRIMARY KEY,image TEXT,boundary TEXT,select_type INTEGER,card_name TEXT,color TEXT,payment_date TEXT,cut_of_date TEXT,cash_advance_limit TEXT,point INTEGER,last_numbers TEXT)');
    await db.execute(
        'CREATE TABLE Process (id INTEGER ,card_id INTEGER,process_type INTEGER,date_time TEXT,company_name TEXT,comment TEXT,amount TEXT,installments INTEGER,points_earned INTEGER,points_spent INTEGER,picture TEXT,  FOREIGN KEY("card_id") REFERENCES "Cards"("id"), PRIMARY KEY("id")) ');
  }

  Future<List<WACardModel>> getCards() async {
    count = await getCount();
    print("the count " + count.toString());
    var dbClient = await db;
    var result = await dbClient.query("Cards", orderBy: "card_name");
    print(result);
    return result.map((data) => WACardModel.fromMap(data)).toList();
  }

  Future<int> insertCard(
    WACardModel card,
  ) async {
    var dbClient = await db;

    notifyListeners();
    return await dbClient.insert("Cards", card.toMap());
  }

  Future<int> updateCard(WACardModel card) async {
    var dbClient = await db;
    return await dbClient
        .update("Cards", card.toMap(), where: "id=?", whereArgs: [card.id]);
  }

  Future<int> getCount() async {
    //database connection
    var dbClient = await db;
    var x = await dbClient.rawQuery('SELECT COUNT (*) FROM  Cards');
    int count = Sqflite.firstIntValue(x);
    return count;
  }

/*   Future<void> removeCard(int id) async {
    var dbClient = await db;
    return await dbClient.delete("Cards", where: "id=?", whereArgs: [id]);
  }
 */
  void removeCard(var id) async {
    var dbClient = await db;
    try {
      await dbClient.rawQuery('DELETE FROM Process  WHERE card_id = $id');
      await dbClient.rawQuery('DELETE FROM Cards WHERE id = $id');
    } on Exception catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<ProcessModel> getProcessSingle(int id) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery('SELECT * FROM Process WHERE id = $id');
    print(result);
    return ProcessModel.fromMap(result.first);
  }

  Future<List<ProcessData>> getProcess() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        'SELECT Process.id,date_time,process_type,company_name,comment,amount,card_name FROM Process JOIN Cards ON Cards.id=Process.card_id');
    return result.map((data) => ProcessData.fromMap(data)).toList();
  }

  Future<int> insertProcess(ProcessModel process) async {
    var dbClient = await db;
    return await dbClient.insert("Process", process.toMap());
  }
}
