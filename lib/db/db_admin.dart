import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? _myDataBse;
//Patron singleton
  static final DBAdmin _instance = DBAdmin._();
  //constructor con nombre
  DBAdmin._();

  factory DBAdmin() {
    return _instance;
  }

//fin patron

  Future<Database?> _checkDataBase() async {
    //primera forma
    /*if (myDataBse == null) {
      myDataBse = await initDatabase();
    } else {
      return myDataBse;
    }
    return myDataBse;*/
    // segunda forma
    //myDataBse ??= initDatabase();

    //tercera forma
    if (_myDataBse == null) {
      _myDataBse = await _initDatabase();
    }
    return _myDataBse;
  }
  //checkDataBase() async {
//    if
  //}

  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDataBase = join(directory.path, "BuillsDB.db");
    return await openDatabase(
      pathDataBase,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute("""CREATE TABLE BILL( 
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          product TEXT,
          price INT,
          datetime TEXT,
          type TEXT,
          monto REAL,
          cantidad REAL)""");
      },
    );
  }

  ///CRUD
//Obtener gasto
  obtenerGasto() async {
    Database? db = await _checkDataBase();
    //forma 1
    List data1 = await db!.query("BILL");

    //forma 2
    List data2 = await db!.query("BILL",
        columns: [
          "id",
          "product",
          "price",
          "type",
        ],
        where: "type = 'Kg.'");
//formar 3
    List data3 = await db!.query("BILL", columns: [
      "id",
      "product",
      "price",
      "type",
    ]);

    //forma 4
    List data4 = await db!.rawQuery(
        "SELECT id, product, price,type FROM BILL WHERE type = 'Kg.'");
    print(data3);
  }

//Insertar gasto
  //insertarGasto(String product, double price, String type) async {
  insertarGasto(Map<String, dynamic> data) async {
    Database? db = await _checkDataBase();
    int resp = await db!.insert(
      "BILL",
      /*{
        "product": product,
        "price": price,
        "type": type,
        
      },*/
      data,
    );

    print(resp);
  }

//Actualizar gasto
//Eliminar gasto
}
