import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/shared/transaction_card.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  @override
  Widget build(BuildContext context) {

    final recentTransactions = ref.watch(recentTransactionsProvider);
    final totalExpenses = ref.watch(totalExpensesProvider);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  color: AppColors.secondaryBackground
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TextMedium('Total Expenses'),
                        TitleLarge('$totalExpenses\$')
                      ],
                    ),
                  )
                ]
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeadlineMedium('Recent Transactions'),
                  TextButton(onPressed: () {
                    context.pushNamed('AllExpenses');
                  }, child: const TextMedium('View All'))
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
              itemCount: recentTransactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(recentTransactions[index]);
              },
            )
            )
          ],
        )
      ),
    );
  }
}