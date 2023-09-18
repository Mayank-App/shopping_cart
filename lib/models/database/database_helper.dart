import 'package:sqflite/sqflite.dart';
import "package:path_provider/path_provider.dart";
import 'dart:io' as io;

import 'database_model/cart_model.dart';


class DBHelper{

  static Database? _db;
  Future<Database> get db async{
    if(_db !=  null)
    {
      return _db!;
    }
    return _db = await initDatabase();
  }

  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
   // String path =join(documentDirectory.path,'cart.db');
   String path = '${documentDirectory.path}note.db';
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
   _onCreate(Database db,int version)async{
    await  db.execute(
      'CREATE TABLE cart(id INTEGER PRIMARY KEY,productId VARCHAR UNIQUE,productName TEXT,intialPrize INTEGER,productPrize INTEGER,quantity INTEGER,unitTag TEXT,image TEXT)'
    );

   }
   Future<Cart> inserts(Cart cart) async{
    final dbClient = await db;
    await dbClient.insert("cart", cart.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return cart;
   }

   Future<Cart> insertIntoDB(Cart cart) async {
    final databaseClient = await db;
    await databaseClient.insert("cart", cart.toMap());
    return cart;
   }
}