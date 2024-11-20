import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/shared/date_picker_form_field.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCreditCard extends ConsumerStatefulWidget {
  const CreateCreditCard({super.key});

  @override
  ConsumerState<CreateCreditCard> createState() => _CreateCreditCardState();
}

class _CreateCreditCardState extends ConsumerState<CreateCreditCard> {

  final _formGlobalKey = GlobalKey<FormState>();
  String _name = '';
  String _balance = '';
  String _creditLimit = '';
  double _rewards = 0;
  String _interestRate = '';
  String _dueDate = '';

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
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
              const Center(child: HeadlineMedium('New Credit Card')),
              Expanded(
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: const HeadlineSmall('Name'),
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
                          _name  = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: InputDecoration(
                          label: const HeadlineSmall('Balance'),
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
                          _balance = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          label: const HeadlineSmall('Credit Limit'),
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
                          _creditLimit = v!;
                        },
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: InputDecoration(
                          label: const HeadlineSmall('Interest Rate'),
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
                          _interestRate = v!;
                        },
                      ),
                      const SizedBox(height: 20,),
                      DatePickerFormField(
                        context: context,
                        decoration: const InputDecoration(
                          label: HeadlineSmall('Due Date'),
                          hintText: ''
                        ),
                        validator: (v) {
                          if (v == null) {
                            return 'You must select the date';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _dueDate = v.toString();
                        },
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                        ],
                        decoration: InputDecoration(
                          label: const HeadlineSmall('Rewards'),
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
                          _rewards = double.parse(v!);
                        },
                      ),
                      const SizedBox(height: 40),
                      Center(child: 
                      FilledButton(
                        onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          final _user = ref.read(userProvider);
                            ref.read(creditCardsProvider.notifier).addCreditCard(
                            CreditCard(
                              name: _name,
                              id: '1',
                              balance: _balance,
                              creditLimit: _creditLimit,
                              interestRate: _interestRate,
                              dueDate: _dueDate,
                              rewards: _rewards,
                              userId: _user.id
                            ));
                          
                          _formGlobalKey.currentState!.reset();
                          
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
            ],
          ),
        ),
      )
    );
  }
}