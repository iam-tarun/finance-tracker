import 'package:finance_tracker/models/transaction_model.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:finance_tracker/utils.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(this.transaction, {super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
      margin: const EdgeInsets.symmetric(vertical: 15,  horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.accentColor,
            child: const Icon(Icons.category, color: Colors.black,)
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextLarge(transaction.description),
                const SizedBox(height: 5,),
                TextSmall(formatDateString(transaction.date))
              ],
            )
          ),
          HeadlineMedium('\$${transaction.amount.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}