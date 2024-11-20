import 'package:finance_tracker/providers/categories_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:finance_tracker/shared/category_card_display.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({super.key});

  @override
  ConsumerState<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {

  @override
  Widget build(BuildContext context) {

    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: 
          GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            itemCount: categories.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              if (index == categories.length) {
                return GestureDetector(
                  onTap: () {
                    context.pushNamed('NewCategory');
                  },
                  child: Card(
                    color: AppColors.secondaryBackground,
                    child: Center(
                      child: Icon(Icons.add, size: 40.0, color: AppColors.primaryColor),
                    )
                  )
                ); 
              }
              return CategoryCardDisplay(categories[index]); 
            },
          )
        )
        ],
      ),
    );
  }
}