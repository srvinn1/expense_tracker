import 'package:expense_tracker/expenses/presentation/components/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_cubit/transaction_cubit.dart';
import '../components/money_info_box.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD0B7ff),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  if (state.totalExpenses != null &&
                      state.totalIncomes != null) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MoneyInfoBox(
                          amount: state.totalIncomes!.toInt(),
                          isIncome: true,
                        ),
                        MoneyInfoBox(amount: state.totalExpenses!.toInt()),
                      ],
                    );
                  } else if (state.isLoading) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MoneyInfoBox(
                          amount: 0,
                          isIncome: true,
                        ),
                        MoneyInfoBox(amount: 0),
                      ],
                    );
                  } else if (state.errorMessage != null) {
                    return Center(child: Text(state.errorMessage!));
                  }
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MoneyInfoBox(
                        amount: 0,
                        isIncome: true,
                      ),
                      MoneyInfoBox(amount: 0),
                    ],
                  );
                },
              ),
              const SizedBox(height: 54),
            ],
          ),
        ),
        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state.allTransactions != null) {
              var transactionToShow = state.allTransactions!.take(5);
              return Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Expenses',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Visibility(
                            visible: state.allTransactions != null &&
                                state.allTransactions!.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 17),
                              child: TextButton(
                                  onPressed: () {
                                    _showAllExpensesBottomSheet(context);
                                  },
                                  child: const Text('Show all')),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: transactionToShow
                          .map((transaction) => TransactionCard(
                                category: transaction.category,
                                description: transaction.description,
                                isExpense: transaction.type == 'expense',
                                amount: transaction.amount,
                                date: transaction.date,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            if (state.allTransactions == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
            return const Text('No transactions yet');
          },
        ),
      ],
    );
  }
}

void _showAllExpensesBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 1,
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state.allTransactions != null &&
                state.allTransactions!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView(
                  children: state.allTransactions!
                      .map((transaction) => TransactionCard(
                            category: transaction.category,
                            description: transaction.description,
                            isExpense: transaction.type == 'expense',
                            amount: transaction.amount,
                            date: transaction.date,
                          ))
                      .toList(),
                ),
              );
            }
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No expenses found'),
            );
          },
        ),
      );
    },
  );
}
