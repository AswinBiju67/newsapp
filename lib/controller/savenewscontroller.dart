import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Savenewscontroller with ChangeNotifier {
  static late Database databas;
  List<Map> cartitem = [];


  static Future<void> initializeDatabase() async {
    databas = await openDatabase(
      "Cart1.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE News (id INTEGER PRIMARY KEY, tittle TEXT, image TEXT)');
      },
    );
  }

  Future addnews({
    required BuildContext context,
    required String tittle,
    required String image,
  }) async {
    await getnews();
    bool alreadyadd = false;
    for (int i = 0; i < cartitem.length; i++) {
      if (cartitem[i]["tittle"] == tittle) {
        alreadyadd = true;
      }
    }
    if (alreadyadd == false) {
      await databas.rawInsert('INSERT INTO News(tittle, image) VALUES(?, ?)',
          [tittle, image]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green, content: Text("News Bookmarked")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: Text("News Already Bookmarked")));
    }

    notifyListeners();
    log(cartitem.toString());
  }

  removenews({required int id}) async {
    await databas.rawDelete('DELETE FROM News WHERE id = ?', [id]);
    await getnews();
    notifyListeners();
  }

  Future<void> getnews() async {
    cartitem = await databas.rawQuery('SELECT * FROM News');
    log(cartitem.toString());

    notifyListeners();
  }
}
