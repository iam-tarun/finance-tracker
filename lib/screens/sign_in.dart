import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class  SignIn extends ConsumerWidget {
  SignIn ({super.key});

  final signInFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  label: const HeadlineSmall('Email'),
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
                  _email  = v!;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  label: const HeadlineSmall('Password'),
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
                      FilledButton(onPressed: () async {
                        if (signInFormKey.currentState!.validate()) {
                          signInFormKey.currentState!.save();

                          final authRepo = ref.read(authRepositoryProvider);
                          final error = await authRepo.signInWithEmailAndPassword(_email, _password);

                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: TextMedium(error)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: TextMedium('Sign-in successful!')),
                            );
                            context.goNamed('Home');
                          }
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
                    ),
                    const SizedBox(height: 20,),
                    const Center(child: TextMedium('New here?')),
                    TextButton(onPressed: () {
                      context.goNamed('SignUp');
                    }, child: const TextMedium('Register account'))
            ],
          ),
        ),
      ),
    );
  }
}