import 'package:expense_tracker/expenses/data/models/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../../domain/repo/i_transaction.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE transactions (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          amount REAL NOT NULL,
          date TEXT NOT NULL,
          category TEXT NOT NULL,
          type TEXT NOT NULL
        )
      ''');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < 2) {
        await db.execute(
            'ALTER TABLE transactions ADD COLUMN type TEXT NOT NULL DEFAULT "unknown"');
      }
    });
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await database;
    await db.insert('transactions', transaction.toMap());
  }

  @override
  Future<List<TransactionModel>> getTransactionsByMonth(
    String type,
    DateTime month,
  ) async {
    final db = await database;
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);

    final result = await db.query(
      'transactions',
      where: 'type = ? AND date >= ? AND date <= ?',
      whereArgs: [
        type,
        monthStart.toIso8601String(),
        monthEnd.toIso8601String()
      ],
      orderBy: 'date DESC',
    );

    return result.map(TransactionModel.fromMap).toList();
  }

  @override
  Future<void> clearDB() async {
    final db = await database;
    await db.delete('transactions');
  }

  Future<void> resetDatabase() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.execute('DROP TABLE IF EXISTS transactions');
      await txn.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');
    });
  }

  @override
  Future<double> countIncome(DateTime month) async {
    final db = await database;
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(amount) as totalIncome
    FROM transactions
    WHERE type = 'income' AND date >= ? AND date <= ?
  ''', [monthStart.toIso8601String(), monthEnd.toIso8601String()]);

    if (result.first['totalIncome'] != null) {
      return result.first['totalIncome'] as double;
    } else {
      return 0.0;
    }
  }

  @override
  Future<double> countExpenses(DateTime month) async {
    final db = await database;
    final monthStart = DateTime(month.year, month.month, 1);
    final monthEnd = DateTime(month.year, month.month + 1, 0);

    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(amount) as totalExpense
    FROM transactions
    WHERE type = 'expense' AND date >= ? AND date <= ?
  ''', [monthStart.toIso8601String(), monthEnd.toIso8601String()]);

    if (result.first['totalExpense'] != null) {
      return result.first['totalExpense'] as double;
    } else {
      return 0.0;
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final result = await db.query('transactions', orderBy: 'date DESC');
    return result.map(TransactionModel.fromMap).toList();
  }
}
