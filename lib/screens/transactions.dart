import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/shared/transaction_card.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Transactions extends ConsumerStatefulWidget {
  const Transactions({super.key});

  @override
  ConsumerState<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends ConsumerState<Transactions> {


  @override
  Widget build(BuildContext context) {

    final _transactions = ref.read(transactionProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return TransactionCard(_transactions[index]);
            },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'FilterTransactionsButton',
        onPressed: () {},
        backgroundColor: AppColors.primaryTextColor,
        child: Icon(Icons.filter_alt, color: AppColors.backgroundColor),
      ),
    );
  }
}