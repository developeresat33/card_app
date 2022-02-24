import 'dart:async';

import 'package:card_application/database/db_models/shopping_model.dart';
import 'package:card_application/database/shop_data.dart';
import 'package:card_application/model/wa_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends ChangeNotifier {
  static Database _db;

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
        'CREATE TABLE Shopping (id INTEGER ,card_id INTEGER,date_time TEXT,company_name TEXT,comment TEXT,amount TEXT,installments INTEGER,points_earned INTEGER,points_spent INTEGER,picture TEXT,  FOREIGN KEY("card_id") REFERENCES "Cards"("id"), PRIMARY KEY("id")) ');
  }

  Future<List<WACardModel>> getCards() async {
    var dbClient = await db;
    var result = await dbClient.query("Cards", orderBy: "card_name");
    print(result);
    return result.map((data) => WACardModel.fromMap(data)).toList();
  }

  Future<int> insertCard(WACardModel card) async {
    print("sdsds");
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

  Future<List<ShopData>> getShopping() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        'SELECT company_name,comment,amount,card_name FROM Shopping JOIN Cards ON Cards.id=Shopping.card_id');
    print(result);
    return result.map((data) => ShopData.fromMap(data)).toList();
  }

  Future<int> insertShopping(ShoppingModel shop) async {
    print("sdsds");
    var dbClient = await db;
    return await dbClient.insert("Shopping", shop.toMap());
  }
}
