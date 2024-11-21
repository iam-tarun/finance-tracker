import 'package:finance_tracker/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

class SignIn extends ConsumerWidget {
  SignIn({Key? key}) : super(key: key);

  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn(
      BuildContext context, WidgetRef ref, String email, String password) async {
    final firebaseAuth = ref.read(firebaseAuthProvider);

    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully')),
      );
      // Navigate to the home screen or another page
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleMedium('Finance Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _signInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username or Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 20.0,
                ),
                maxLength: 40,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter the username or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontSize: 20.0,
                ),
                maxLength: 40,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter the password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: FilledButton(
                  onPressed: () {
                    if (_signInFormKey.currentState!.validate()) {
                      _signIn(
                        context,
                        ref,
                        _usernameController.text.trim(),
                        _passwordController.text.trim(),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    foregroundColor: AppColors.primaryTextColor,
                  ),
                  child: const TextMedium('Sign In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
