import 'package:finance_tracker/models/bar_data_model.dart';
import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/shared/card_stats.dart';
import 'package:finance_tracker/shared/credit_card_display.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCards extends ConsumerStatefulWidget {
  const CreditCards({super.key});

  @override
  ConsumerState<CreditCards> createState() => _CreditCardsState();
}

class _CreditCardsState extends ConsumerState<CreditCards> {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<BarData> data = [BarData(numBars: 7, barAmounts: [20, 30, 40, 10, 50, 30, 30], maxY: 60.0, minY: 0.0, xAxisLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']),
  BarData(numBars: 7, barAmounts: [10, 30, 20, 10, 40, 30, 10], maxY: 60.0, minY: 0.0, xAxisLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']),
  BarData(numBars: 7, barAmounts: [50, 10, 50, 30, 20, 30, 40], maxY: 60.0, minY: 0.0, xAxisLabels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'])
  
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

    return buildCreditCards(context, cards.value ?? []);

  }
  
  Widget buildCreditCards(BuildContext context, List<CreditCard> cards) {
    
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Visibility(
                visible: cards.isNotEmpty,
                replacement: const SizedBox(height: 20, child: Center(child: HeadlineMedium('No Cards to Display'))),
                child: PageView.builder(
                itemCount: cards.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: CreditCardDisplay(cards[index])
                    );
                },
              )
            )
            ),
            const SizedBox(height: 20,),
            cards.isNotEmpty ? CardStats(cards[_currentPage], data[_currentPage]) : const SizedBox.shrink()
    
          ]
        ),
      
    );
  }
}