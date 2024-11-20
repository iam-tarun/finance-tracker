import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/shared/transaction_card.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllTransactions extends ConsumerStatefulWidget {
  const AllTransactions({super.key});

  @override
  ConsumerState<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends ConsumerState<AllTransactions> {

  @override
  Widget build(BuildContext context) {

    final _transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const HeadlineSmall('All Transactions'),
      ),
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
        onPressed: () {},
        backgroundColor: AppColors.primaryTextColor,
        child: Icon(Icons.filter_alt, color: AppColors.backgroundColor),
      ),
    );
  }
}