import 'package:expense_tracker/expenses/data/models/transaction_model.dart';

abstract class ITransactionRepository {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTransactionsByMonth(
    String type,
    DateTime month,
  );
  Future<void> clearDB();

  Future<double> countIncome(DateTime month);
  Future<double> countExpenses(DateTime month);
  Future<List<TransactionModel>> getAllTransactions();
}
