import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String pathDataBase = join(directory.path, "BuillsDB.db");
    openDatabase(
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
//Insertar gasto
//Actualizar gasto
//Eliminar gasto
}
