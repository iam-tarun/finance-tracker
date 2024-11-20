import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:finance_tracker/utils.dart';
import 'package:flutter/material.dart';

class CreditCardDisplay extends StatelessWidget {
  const CreditCardDisplay(this.card, {super.key});

  final CreditCard card;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      color: AppColors.secondaryBackground,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeadlineMedium(card.name),
                TextMedium('Due on ${formatDateString(card.dueDate)}')
              ],
            ),
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeadlineSmall('Balance'),
                const SizedBox(width: 16,),
                TitleSmall('\$${card.balance}')
              ],
            )
          ],
        ),
      )
    );
  }
}