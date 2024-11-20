import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';

class CategoryCardDisplay extends StatelessWidget {
  const CategoryCardDisplay(this.data, {super.key});

  final Category data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  radius: 10.0,
                  child: const Icon(Icons.category, color: Colors.black, size: 16.0,),
                ),
                const SizedBox(width: 10,),
                TextLarge(data.name),
              ] 
            ),
            const SizedBox(height: 8.0,),
            const TitleSmall('\$322')
          ],
        )
      )
    );
  }
}