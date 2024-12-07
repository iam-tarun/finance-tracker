import 'package:finance_tracker/models/transaction_model.dart';
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
    final transactions = ref.watch(transactionProvider);

    if (transactions.isLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (transactions.hasError) {
      return Scaffold(
        body: Center(
          child: TextMedium(
            'Error: ${transactions.error}',
          ),
        ),
      );
    }

    return buildTransactions(context, transactions.value ?? []);

  }

  Widget buildTransactions(BuildContext context, List<Transaction> transactions) {

    

    return Scaffold(
      appBar: AppBar(
        title: const HeadlineSmall('All Transactions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionCard(transactions[index]);
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