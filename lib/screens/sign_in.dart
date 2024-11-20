import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';

class  SignIn extends StatelessWidget {
  SignIn ({super.key});

  final signInFormKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleMedium('Finance Tracker'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: signInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeadlineLarge('Sign In'),
              const SizedBox(height: 40,),
              TextFormField(
                decoration: InputDecoration(
                  label: const HeadlineSmall('username or email'),
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
                    return 'You must enter the username or email';
                  }
                  return null;
                },
                onSaved: (v) {
                  _username  = v!;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  label: const HeadlineSmall('password'),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor
                    )
                  )
                ),
                obscureText: true,
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
                  _password  = v!;
                },
              ),
              const SizedBox(height: 40,),
              Center(child: 
                      FilledButton(onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          final _user = ref.read(userProvider);
                          ref.read(transactionProvider.notifier).addTransaction(
                              Transaction(id: '1', categoryId: _selectedCategory, description: _description, date: _date, amount: _amount, userId: _user.id, cardId: _selectedCard)
                            );

                          _formGlobalKey.currentState!.reset();
                          _selectedCategory = _categories[0].id;
                          _selectedCard = _cards[0].id;
                        }
                      }, 
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                        ),
                        foregroundColor: AppColors.primaryTextColor
                      ),
                      child: const HeadlineMedium('SignIn'),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}