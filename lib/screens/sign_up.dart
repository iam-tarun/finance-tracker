import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class  SignUp extends ConsumerWidget {
  SignUp ({super.key});

  final signUpFormKey = GlobalKey<FormState>();
  String _username = '';
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
          key: signUpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeadlineLarge('Sign Up'),
              const SizedBox(height: 40,),
              TextFormField(
                decoration: InputDecoration(label: const HeadlineSmall('Username'),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor
                    )
                  )),
                maxLength: 40,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter a username';
                  }
                  return null;
                },
                onSaved: (v) {
                  _username = v!;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(label: const HeadlineSmall('Email'),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor
                    )
                  )),
                keyboardType: TextInputType.emailAddress,
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter an email';
                  }
                  else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                    return 'You must enter a valid email address';
                  }
                  return null;
                },
                onSaved: (v) {
                  _email= v!;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(label: const HeadlineSmall('Password'),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor
                    )
                  )),
                obscureText: true,
                maxLength: 40,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter a password';
                  }
                  else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (v) {
                  _password = v!;
                },
              ),
              const SizedBox(height: 40,),
              Center(
                child: ElevatedButton(onPressed: () async {
                  if (signUpFormKey.currentState!.validate()) {
                    signUpFormKey.currentState!.save();

                    final authRepo = ref.read(authRepositoryProvider);
                    final error = await authRepo.signUpWithEmailAndPassword(_email, _password);

                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: TextMedium(error)),
                      );
                    } else {
                      //TODO:
                      // save username to firestore or user database
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: TextMedium('Sign-up successful!')),
                      );
                      context.goNamed('SignIn');
                    }
                  }
                }, child: const TextMedium('Sign Up'))
              ),
              const SizedBox(height: 20,),
              const Center(child: TextMedium('Already have an account?')),
              TextButton(onPressed: () {
                context.goNamed('SignIn');
              }, child: const TextMedium('Sign In'))
            ],
          )
        )
      )
    );
  }
}