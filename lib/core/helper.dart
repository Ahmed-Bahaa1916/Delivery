import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../infrastructure/models/order_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "orders.db");

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        billSrl TEXT PRIMARY KEY,
        status TEXT,
        totalPrice REAL,
        date TEXT
      )
    ''');
  }

  //CRUD

  // Insert Order
  Future<int> insertOrder(OrderModel order) async {
    final db = await database;
    return await db.insert(
      "orders",
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All Orders
  Future<List<OrderModel>> getOrders() async {
    final db = await database;
    final maps = await db.query("orders");

    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  // Delete Order
  Future<int> deleteOrder(String billSrl) async {
    final db = await database;
    return await db.delete(
      "orders",
      where: "billSrl = ?",
      whereArgs: [billSrl],
    );
  }

  // Update Order
  Future<int> updateOrder(OrderModel order) async {
    final db = await database;
    return await db.update(
      "orders",
      order.toMap(),
      where: "billSrl = ?",
      whereArgs: [order.billSrl],
    );
  }
}
