import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DbHelper {
  static Database? _database;
  static final DbHelper instance = DbHelper._privateConstructor();

  DbHelper._privateConstructor();

  // Veritabanına erişim sağlayan fonksiyon
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // Veritabanını başlatan ve yolunu belirleyen fonksiyon
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
    return await db!.insert('transactions', {
      'amount': transaction.amount,
      'description': transaction.description,
      'date': transaction.date,
    });
  }

  // Tüm işlemleri getiren fonksiyon
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

  // Bir işlemi güncellemek için kullanılan fonksiyon
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

  // Bir işlemi silmek için kullanılan fonksiyon
  Future<int> deleteTransaction(int id) async {
    Database? db = await instance.database;
    return await db!.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}

// İşlem modeli
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
  })  : assert(id >=
            0), // Eksik: ID'nin 0'dan büyük veya eşit olduğunu kontrol edin
        assert(amount >=
            0), // Eksik: Amount'un 0'dan büyük veya eşit olduğunu kontrol edin
        assert(description
            .isNotEmpty), // Eksik: Description'ın boş olmadığını kontrol edin
        assert(date.isNotEmpty); // Eksik: Date'in boş olmadığını kontrol edin
}
