import 'package:finance_tracker/models/transaction_model.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
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

    final transactions = ref.read(transactionProvider);

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
        heroTag: 'FilterTransactionsButton',
        onPressed: () {},
        backgroundColor: AppColors.primaryTextColor,
        child: Icon(Icons.filter_alt, color: AppColors.backgroundColor),
      ),
    );
  }
}