// db_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DbHelper {
  static Database? _database;
  static final DbHelper instance = DbHelper._privateConstructor();

  DbHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'finance_database.db');

    try {
      return await openDatabase(path, version: 1, onCreate: _createDb);
    } catch (e) {
      print("Error opening database: $e");
      throw Exception('Failed to open database');
    }
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        description TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertTransaction(
      double amount, String description, String date) async {
    if (amount <= 0 || description.isEmpty) {
      throw Exception('Amount and description are required.');
    }

    Database? db = await instance.database;
    return await db!.insert('transactions', {
      'amount': amount,
      'description': description,
      'date': date,
    });
  }

  Future<List<Transaction>> getTransactions() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> maps = await db!.query('transactions');
    return List.generate(maps.length, (i) {
      return Transaction(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        date: maps[i]['date'],
      );
    });
  }

  Future<int> updateTransaction(Transaction transaction) async {
    Database? db = await instance.database;
    return await db!.update(
      'transactions',
      {
        'id': transaction.id,
        'amount': transaction.amount,
        'description': transaction.description,
        'date': transaction.date,
      },
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    Database? db = await instance.database;
    return await db!.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}

class Transaction {
  final int id;
  final double amount;
  final String description;
  final String date;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          amount == other.amount &&
          description == other.description &&
          date == other.date;
}
