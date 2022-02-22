import 'dart:async';

import 'package:card_application/model/wa_card_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "CardApp.db");
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    return await await db.execute(
        "CREATE TABLE Cards id INTEGER PRIMARY KEY,limit TEXT ,cashAdvanceLimit TEXT,cardName TEXT, paymentDate TEXT,cutOfDate TEXT, point INTEGER,selectType INTEGER,color TEXT");
  }

  Future<List<WACardModel>> getCards() async {
    var dbClient = await db;
    var result = await dbClient.query("Cards", orderBy: "name");
    return result.map((data) => WACardModel.fromMap(data)).toList();
  }

  Future<int> insertCard(WACardModel card) async {
    var dbClient = await db;
    return await dbClient.insert("Cards", card.toMap());
  }

  Future<int> updateCard(WACardModel card) async {
    var dbClient = await db;
    return await dbClient
        .update("Cards", card.toMap(), where: "id=?", whereArgs: [card.id]);
  }

  Future<void> removeCard(int id) async {
    var dbClient = await db;
    return await dbClient.delete("Cards", where: "id=?", whereArgs: [id]);
  }
}
