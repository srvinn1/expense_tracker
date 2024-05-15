// part of 'transaction_cubit.dart';

// abstract class TransactionState extends Equatable {
//   const TransactionState();
// }

// class TransactionInitial extends TransactionState {
//   @override
//   List<Object> get props => [];
// }

// class TransactionLoading extends TransactionState {
//   @override
//   List<Object> get props => [];
// }

// class TransactionsLoaded extends TransactionState {
//   final List<TransactionModel> expenses;
//   final List<TransactionModel> incomes;

//   const TransactionsLoaded({required this.expenses, required this.incomes});

//   @override
//   List<Object> get props => [expenses, incomes];
// }

// class StatsLoaded extends TransactionState {
//   final double expenses;
//   final double incomes;

//   const StatsLoaded({required this.expenses, required this.incomes});

//   @override
//   List<Object> get props => [expenses, incomes];
// }

// class TransactionError extends TransactionState {
//   final String message;

//   const TransactionError(this.message);

//   @override
//   List<Object> get props => [message];
// }

part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final bool isLoading;
  final double? totalExpenses;
  final double? totalIncomes;
  final String? errorMessage;
  final List<TransactionModel>? expenses;
  final List<TransactionModel>? incomes;
  final List<TransactionModel>? allTransactions;

  const TransactionState({
    this.isLoading = false,
    this.expenses,
    this.incomes,
    this.totalExpenses,
    this.totalIncomes,
    this.errorMessage,
    this.allTransactions,
  });

  TransactionState copyWith({
    bool? isLoading,
    List<TransactionModel>? expenses,
    List<TransactionModel>? incomes,
    double? totalExpenses,
    double? totalIncomes,
    String? errorMessage,
    List<TransactionModel>? allTransactions,
  }) {
    return TransactionState(
      isLoading: isLoading ?? false,
      expenses: expenses ?? this.expenses,
      incomes: incomes ?? this.incomes,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      totalIncomes: totalIncomes ?? this.totalIncomes,
      errorMessage: errorMessage ?? '',
      allTransactions: allTransactions ?? this.allTransactions,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        expenses,
        incomes,
        totalExpenses,
        totalIncomes,
        errorMessage,
        allTransactions,
      ];
}
