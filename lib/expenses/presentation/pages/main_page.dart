import 'package:expense_tracker/expenses/presentation/bloc/tab_cubit/tab_cubit.dart';
import 'package:expense_tracker/expenses/presentation/components/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/transfers_appbar.dart';
import 'add_transaction_body.dart';
import 'home_body.dart';
import 'transfers_body.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final bodies = [
    const HomeBody(),
    const AddTransactionBody(),
    const TransfersBody(),
  ];
  final appBars = [
    const HomeAppBar(),
    AppBar(),
    const TransfersAppBar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 1
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: BlocBuilder<TabCubit, int>(
                builder: (context, state) {
                  return AppBar(
                    backgroundColor: context.read<TabCubit>().backgroundColor,
                    automaticallyImplyLeading: false,
                  );
                },
              ),
            )
          : appBars[_selectedIndex],
      body: bodies[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 33,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 55,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.swap_horiz,
              size: 33,
            ),
            label: 'Transfers',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        iconSize: 24,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
