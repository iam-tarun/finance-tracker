import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/models/transaction_model.dart';
import 'package:finance_tracker/providers/categories_provider.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/shared/date_picker_form_field.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});
  

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {

  final _formGlobalKey = GlobalKey<FormState>();

  String _description = '';
  double _amount = 0;
  String _date = '';

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final cards = ref.watch(creditCardsProvider);

    if (categories.isLoading ||  cards.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (categories.hasError || cards.hasError) {
      return Scaffold(
        body: Center(
          child: TextMedium(
            'Error: ${categories.error ?? cards.error}',
          ),
        ),
      );
    }

    return buildNewExpense(context, categories.value ?? [], cards.value ?? []); 
  }

  Widget buildNewExpense(BuildContext context, List<Category> categories, List<CreditCard> cards) {

    bool _showForm = true;

    var _selectedCategory = categories.isEmpty ? '' : categories[0].id;

    
    var _selectedCard = cards.isEmpty ? '' : cards[0].id;

    if (cards.isEmpty || categories.isEmpty) {
      _showForm = false;
    }

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              const Center(child: HeadlineMedium('New Expense')),
              Expanded(
                child: Visibility(
                  visible: _showForm,
                  replacement: const HeadlineMedium('Please Create new Card and new Category before adding expense'),
                  child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: const HeadlineSmall('description'),
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
                        maxLength: 40,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must enter the description';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _description  = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      DropdownButtonFormField(
                        value: _selectedCategory,
                        dropdownColor: AppColors.primaryColor,
                        items: categories.map((v) {
                          return DropdownMenuItem(
                            value: v.id,
                            child: HeadlineSmall(v.name)
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            _selectedCategory = v.toString();
                          });
                        },
                        onSaved: (v) {
                          _date = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      DropdownButtonFormField(
                        value: _selectedCard,
                        dropdownColor: AppColors.primaryColor,
                        items: cards.map((v) {
                          return DropdownMenuItem(
                            value: v.id,
                            child: HeadlineSmall(v.name)
                          );
                        }).toList(),
                        onChanged: (v) {
                          setState(() {
                            _selectedCategory = v.toString();
                          });
                        },
                        onSaved: (v) {
                          _date = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: InputDecoration(
                          label: const HeadlineSmall('amount'),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must enter the amount';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _amount = double.parse(v!);
                        },
                      ),
                      const SizedBox(height: 20,),
                      DatePickerFormField(
                        context: context,
                        validator: (v) {
                          if (v == null) {
                            return 'You must select the date';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _date = v.toString();
                        },
                      ),
                      const SizedBox(height: 40),
                      Center(child: 
                      FilledButton(onPressed: () async {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          
                          await ref.read(transactionProvider.notifier).addTransaction(
                              Transaction(categoryId: _selectedCategory, description: _description, date: _date, amount: _amount, cardId: _selectedCard)
                            );

                          _formGlobalKey.currentState!.reset();
                          _selectedCategory = categories[0].id;
                          _selectedCard = cards[0].id;
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
                )
                
                )
                
              )
            ],
          ),
        ),
      )
    );
  }
}