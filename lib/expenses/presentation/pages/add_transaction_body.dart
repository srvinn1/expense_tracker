import 'package:expense_tracker/expenses/data/models/transaction_model.dart';
import 'package:expense_tracker/expenses/presentation/bloc/tab_cubit/tab_cubit.dart';
import 'package:expense_tracker/expenses/presentation/bloc/transaction_cubit/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTransactionBody extends StatefulWidget {
  const AddTransactionBody({super.key});

  @override
  State<AddTransactionBody> createState() => _AddTransactionBodyState();
}

class _AddTransactionBodyState extends State<AddTransactionBody>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late TabController _tabController;

  String _category = '';
  String title = '';
  String description = '';
  String amount = '';
  DateTime selectedDate = DateTime.now();

  final List<String> expenseCategories = [
    'Shopping',
    'Subscription',
    'Food',
    'Transport'
  ];
  final List<String> incomeCategories = [
    'Salary',
    'Freelance',
    'Sales'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _category = expenseCategories.first;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _category = _tabController.index == 0
            ? expenseCategories.first
            : incomeCategories.first;
      });
      context.read<TabCubit>().updateTabIndex(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionCubit, TransactionState>(
      listener: (context, state) {
      },
      child: Column(
        children: [
          BlocBuilder<TabCubit, int>(
            builder: (context, state) {
              return Container(
                height: 80,
                color: context.read<TabCubit>().backgroundColor,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: Colors.white,
                    ),
                    child: TabBar(
                      dividerHeight: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: const Color(0xFF7F3DFF),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              color: _tabController.index == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Income',
                            style: TextStyle(
                              color: _tabController.index == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTransactionForm(expenseCategories),
                  _buildTransactionForm(incomeCategories),
                ],
              ),
            ),
          ),
          BlocBuilder<TabCubit, int>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.read<TabCubit>().backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                    ),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<TransactionCubit>().addTransaction(
                            TransactionModel(
                              title: title,
                              amount: double.parse(amount),
                              date: selectedDate,
                              description: description,
                              category: _category,
                              type: _tabController.index == 0
                                  ? 'expense'
                                  : 'income',
                            ),
                          );
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionForm(List<String> categories) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        DropdownButtonFormField<String>(
          value: _category,
          onChanged: (value) => setState(() => _category = value!),
          onSaved: (value) => _category = value!,
          validator: (value) =>
              value == null ? 'Please select a category' : null,
          items:
              (_tabController.index == 0 ? expenseCategories : incomeCategories)
                  .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(
                color: Color(0xFFF1F1FA),
                width: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38)),
              borderSide: BorderSide(
                color: Color(0xFFF1F1FA),
                width: 1,
              ),
            ),
          ),
          onChanged: (value) => title = value,
          validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38)),
              borderSide: BorderSide(
                color: Color(0xFFF1F1FA),
                width: 1,
              ),
            ),
          ),
          onChanged: (value) => description = value,
          validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(38)),
              borderSide: BorderSide(
                color: Color(0xFFF1F1FA),
                width: 1,
              ),
            ),
          ),
          onChanged: (value) => amount = value,
          validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
        ),
        const SizedBox(height: 16),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
          iconColor: const Color(0xFF7F3DFF),
          title: Text(
            'Date: ${DateFormat('d MMM y').format(selectedDate)}',
          ),
          trailing: const Icon(Icons.calendar_month),
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
        ),
      ],
    );
  }
}
