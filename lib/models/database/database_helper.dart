import 'package:sqflite/sqflite.dart';
import "package:path_provider/path_provider.dart";
import 'dart:io' as io;

import 'database_model/cart_model.dart';

class DBHelper {
  static Database? _db;
  // Database Name
  static const String database_name = "note.db";

  // Table CartHeavenShop
  static const String table_shop_heaven_cart = "cart";

  // CartHeavenShop table columns start
  static const String id = "id";
  static const String productId = "productId";
  static const String productName = "productName";
  static const String initialPrice = "intialPrize";
  static const String productPrice = "productPrize";
  static const String quantity = "quantity";
  static const String unitTag = "unitTag";
  static const String image = "image";
  // CartHeavenShop table columns end
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    return _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path =join(documentDirectory.path,'cart.db');
    String path = '${documentDirectory.path}$database_name';
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table_shop_heaven_cart($id INTEGER PRIMARY KEY,$productId VARCHAR UNIQUE,$productName TEXT,$initialPrice INTEGER,$productPrice INTEGER,$quantity INTEGER,$unitTag TEXT,$image TEXT)');
  }

  Future<Cart> insertIntoDB(Cart cart) async {
    final databaseClient = await db;
    await databaseClient.insert(table_shop_heaven_cart, cart.toMap());

    return cart;
  }

  Future<List<Cart>> fetchData() async {
    final databaseClient = await db;
    List<Map<dynamic, dynamic>> data =
        await databaseClient.query(table_shop_heaven_cart);
    // print(data[0]["productName"]);
    return data.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deletData(int id) async {
    final databaseClient = await db;
    return databaseClient
        .delete(table_shop_heaven_cart, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateData(Cart cart) async {
    final databaseClient = await db;
    return databaseClient.update(table_shop_heaven_cart, cart.toMap(),
        where: "$id=?", whereArgs: [cart.id]);
  }
}
