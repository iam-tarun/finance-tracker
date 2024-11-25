import 'package:finance_tracker/models/user_profile_model.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    return userState.when(
      data: (user) => buildProfile(context, user!, ref),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(child: TextMedium('Error: $error'),),
      )
    );
  }

  Widget buildProfile(BuildContext context, UserProfile user, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300.0,
              child:  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.accentColor,
                      child: const Icon(Icons.person_2_sharp, size: 100,),
                    ),
                  ),
                  TitleSmall(user.username)
                ],
                )
               
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineSmall('User Details'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right, color: AppColors.accentColor,))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineSmall('Credit Cards'),
                    IconButton(onPressed: () {
                      context.pushNamed('UserCreditCards');
                    }, icon: Icon(Icons.arrow_right, color: AppColors.accentColor,))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineSmall('Savings Accounts'),
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right, color: AppColors.accentColor,))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40,),
            Center(
              child: FilledButton(onPressed: () async {
                final authRepository = ref.read(authRepositoryProvider);
                await authRepository.signOut();
                context.goNamed('SignIn');
              }, child: const TextMedium('Sign Out')),
            )
          ],
        ),
      )
    );
  }
}