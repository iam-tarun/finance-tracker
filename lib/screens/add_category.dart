import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/providers/categories_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCategory extends ConsumerWidget {
  AddCategory({super.key});

  final _newCategoryFormKey = GlobalKey<FormState>();
  String _name = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return categories.when(
      data: (categories) => buildCategory(context, categories, ref),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(child: TextMedium('Error: $error'),),
      )
    );
  }

  Widget buildCategory(BuildContext context,List<Category> categories, WidgetRef  ref) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Center(child: TitleSmall('Add New Category'),),
            Expanded(
              child: Form(
                key: _newCategoryFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: const HeadlineSmall('name'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryTextColor
                            )
                          )
                      ),
                      style: TextStyle(
                          color: AppColors.primaryTextColor,
                          fontSize: 20.0
                      ),
                      maxLength: 20,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'You must enter the name';
                          }
                          return null;
                      },
                      onSaved: (v) {
                        _name  = v!;
                      },
                    ),
                  const SizedBox(height: 20,),
                  Center(child: 
                      FilledButton(onPressed: () {
                        if (_newCategoryFormKey.currentState!.validate()) {
                          _newCategoryFormKey.currentState!.save();
                          
                          ref.read(categoriesProvider.notifier).createCategory(Category(name: _name, iconPath: ''));      
                          _newCategoryFormKey.currentState!.reset();
                        }
                      }, 
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        foregroundColor: AppColors.primaryTextColor
                      ),
                      child: const HeadlineMedium('Add'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}