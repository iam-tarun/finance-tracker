import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/screens/create_credit_card.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserCreditCards extends ConsumerStatefulWidget {
  const UserCreditCards({super.key});

  @override
  ConsumerState<UserCreditCards> createState() => _UserCreditCardsState();
}

class _UserCreditCardsState extends ConsumerState<UserCreditCards> {

  void showCreditCardUpdateModal(context) {
    showModalBottomSheet(
      context: context, 
      elevation: 10,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateCreditCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(creditCardsProvider);

    if (cards.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (cards.hasError) {
      return Scaffold(
        body: Center(
          child: TextMedium(
            'Error: ${cards.error}',
          ),
        ),
      );
    }

    return buildCreditCardUpdateModal(context, cards.value ?? []);

  }



  Widget buildCreditCardUpdateModal(BuildContext context, List<CreditCard> cards) {

    

    return Scaffold(
      appBar: AppBar(
        title: const TitleSmall('Credit Cards'),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: TextLarge(cards[index].name),
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBackground,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextMedium('Credit Limit'),
                          const SizedBox(width: 40,),
                          HeadlineMedium(cards[index].creditLimit)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextMedium('Reward Points'),
                          const SizedBox(width: 40,),
                          HeadlineMedium(cards[index].rewards.toString())
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextMedium('Interest Rate'),
                          const SizedBox(width: 40,),
                          HeadlineMedium(cards[index].interestRate)
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: () {}, 
                          icon: const Icon(Icons.edit), color: AppColors.accentColor,),
                          IconButton(onPressed: () {},
                          icon: const Icon(Icons.delete), color: AppColors.errorColor,)
                          ],
                        )
                      ),
                    ]
                  ),
              )],
            );
          },
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreditCardUpdateModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
