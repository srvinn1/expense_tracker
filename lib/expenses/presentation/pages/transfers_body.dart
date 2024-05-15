import 'package:expense_tracker/expenses/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/transaction_card.dart';

class TransfersBody extends StatefulWidget {
  const TransfersBody({super.key});

  @override
  State<TransfersBody> createState() => _TransfersBodyState();
}

class _TransfersBodyState extends State<TransfersBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.expenses != null || state.incomes != null) {
          if (state.expenses!.isEmpty && state.incomes!.isEmpty) {
            return const Center(child: Text('No transactions yet'));
          }
          return ListView(
            children: [
              const SizedBox(height: 20),
              Visibility(
                visible: state.expenses!.isNotEmpty,
                child: const Padding(
                  padding: EdgeInsets.only(left: 17),
                  child: Text(
                    'Expenses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Column(
                children: state.expenses!
                    .map((transaction) => TransactionCard(
                          category: transaction.category,
                          description: transaction.description,
                          isExpense: true,
                          amount: transaction.amount,
                          date: transaction.date,
                        ))
                    .toList(),
              ),
              Visibility(
                visible: state.incomes!.isNotEmpty,
                child: const Padding(
                  padding: EdgeInsets.only(left: 17, top: 20),
                  child: Text(
                    'Income',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Column(
                children: state.incomes!
                    .map((transaction) => TransactionCard(
                          category: transaction.category,
                          description: transaction.description,
                          isExpense: false,
                          amount: transaction.amount,
                          date: transaction.date,
                        ))
                    .toList(),
              ),
            ],
          );
        } else if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        return const SizedBox();
      },
    );
  }
}
