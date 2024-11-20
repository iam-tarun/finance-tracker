import 'package:finance_tracker/models/bar_data_model.dart';
import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/shared/bar_graph.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';

class CardStats extends StatefulWidget {
  const CardStats(this.card, this.data, {super.key});

  final CreditCard card;
  final BarData data;
  

  @override
  State<CardStats> createState() => _CardStatsState();
}

class _CardStatsState extends State<CardStats> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {},style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor), child: const TextLarge('Week')),
              TextButton(onPressed: () {},style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor), child: const TextLarge('Month')),
              TextButton(onPressed: () {},style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor), child: const TextLarge('Year')),
              TextButton(onPressed: () {},style: TextButton.styleFrom(backgroundColor: AppColors.backgroundColor), child: const TextLarge('All'))
            ],
          ),
          const SizedBox(height: 50,),
          SizedBox(height: 350, child: BarGraph(widget.data)),
        ],
      )
    );
  }
}
