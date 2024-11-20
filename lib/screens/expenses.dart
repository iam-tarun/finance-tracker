import 'package:finance_tracker/screens/categories.dart';
import 'package:finance_tracker/screens/transactions.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                child: HeadlineSmall('Categories'),
              ),
              Tab(
                child: HeadlineSmall('Transactions')
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                 Categories(),
                 Transactions()
              ],
            )
          )
        ],
      ),
    );
  }
}