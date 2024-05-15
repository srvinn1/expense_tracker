import 'package:equatable/equatable.dart';
import 'package:expense_tracker/expenses/data/models/transaction_model.dart';
import 'package:expense_tracker/expenses/data/repo/transaction_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit()
      : super(
          const TransactionState(
            totalExpenses: null,
            totalIncomes: null,
            errorMessage: null,
          ),
        );

  final transactionRepository = TransactionRepositoryImpl();
  Future<void> loadTransactionsWithinMonth(DateTime month) async {
    emit(state.copyWith(isLoading: true));
    try {
      final expenses =
          await transactionRepository.getTransactionsByMonth('expense', month);
      final incomes =
          await transactionRepository.getTransactionsByMonth('income', month);
      emit(state.copyWith(expenses: expenses, incomes: incomes));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> getStats(DateTime month) async {
    emit(state.copyWith(isLoading: true));
    try {
      final expenses = await transactionRepository.countExpenses(month);
      final incomes = await transactionRepository.countIncome(month);
      emit(state.copyWith(totalExpenses: expenses, totalIncomes: incomes));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await transactionRepository.addTransaction(transaction);
      final updatedAllTransactions =
          List<TransactionModel>.from(state.allTransactions ?? [])
            ..add(transaction);
      if (transaction.type == 'expense') {
        final updatedExpenses =
            List<TransactionModel>.from(state.expenses ?? [])..add(transaction);
        final newTotalExpenses =
            (state.totalExpenses ?? 0) + transaction.amount;
        emit(state.copyWith(
          isLoading: false,
          expenses: updatedExpenses,
          totalExpenses: newTotalExpenses,
          allTransactions: updatedAllTransactions,
        ));
      } else if (transaction.type == 'income') {
        final updatedIncomes = List<TransactionModel>.from(state.incomes ?? [])
          ..add(transaction);
        final newTotalIncomes = (state.totalIncomes ?? 0) + transaction.amount;
        emit(state.copyWith(
          isLoading: false,
          incomes: updatedIncomes,
          allTransactions: updatedAllTransactions,
          totalIncomes: newTotalIncomes,
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> getAllTransactions() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await transactionRepository.getAllTransactions();
      emit(state.copyWith(allTransactions: result));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
