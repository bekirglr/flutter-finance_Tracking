import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

// Veritabanı işlemleri için yardımcı sınıf
class DbHelper {
  static Database? _database;
  static final DbHelper instance = DbHelper._privateConstructor();

  DbHelper._privateConstructor();

  // Veritabanına erişim sağlayan fonksiyon
  Future<Database?> get database async {
    // Eğer veritabanı mevcutsa, mevcut veritabanını döndür
    if (_database != null) return _database;
    // Eğer veritabanı yoksa, yeni bir tane oluştur
    _database = await _initDatabase();
    return _database;
  }

  // Veritabanını başlatan ve yolunu belirleyen fonksiyon
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'finance_database.db');
    // Veritabanını aç ve oluştur
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // Veritabanında bir tablo oluşturan fonksiyon
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

  // Yeni bir işlem eklemek için kullanılan fonksiyon
  Future<int> insertTransaction(Transaction transaction) async {
    Database? db = await instance.database; // nullable db değişkeni oluşturduk
    // transactions tablosuna veri ekle
    return await db!.insert('transactions', transaction.toMap()); // null check
  }

  // Tüm işlemleri getiren fonksiyon
  Future<List<Transaction>> getTransactions() async {
    Database? db = await instance.database; // nullable db değişkeni oluşturduk
    // transactions tablosundan verileri al ve listeye dönüştür
    List<Map<String, dynamic>> maps =
        await db!.query('transactions'); // null check
    return List.generate(maps.length, (i) {
      return Transaction(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        description: maps[i]['description'],
        date: maps[i]['date'],
      );
    });
  }

  // Bir işlemi güncellemek için kullanılan fonksiyon
  Future<int> updateTransaction(Transaction transaction) async {
    Database? db = await instance.database;
    // İlgili id'ye sahip işlemi güncelle
    return await db!.update('transactions', transaction.toMap(),
        where: 'id = ?', whereArgs: [transaction.id]); // null check
  }

  // Bir işlemi silmek için kullanılan fonksiyon
  Future<int> deleteTransaction(int id) async {
    Database? db = await instance.database;
    // İlgili id'ye sahip işlemi sil
    return await db!.delete('transactions',
        where: 'id = ?', whereArgs: [id]); // null check ekledik
  }
}

// İşlem modeli
class Transaction {
  final int id;
  final double amount;
  final String description;
  final String date;

  Transaction(
      {required this.id,
      required this.amount,
      required this.description,
      required this.date});

  // İşlem modelini map'e dönüştüren fonksiyon
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'date': date,
    };
  }
}
