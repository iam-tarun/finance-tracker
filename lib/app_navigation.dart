import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/screens/add_category.dart';
import 'package:finance_tracker/screens/all_transactions.dart';
import 'package:finance_tracker/screens/credit_cards.dart';
import 'package:finance_tracker/screens/expenses.dart';
import 'package:finance_tracker/screens/home.dart';
import 'package:finance_tracker/screens/navigation.dart';
import 'package:finance_tracker/screens/notifications.dart';
import 'package:finance_tracker/screens/profile.dart';
import 'package:finance_tracker/screens/savings_accounts.dart';
import 'package:finance_tracker/screens/sign_in.dart';
import 'package:finance_tracker/screens/sign_up.dart';
import 'package:finance_tracker/screens/user_credit_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/signIn';

  /// Private Navigator Keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorCards = GlobalKey<NavigatorState>();
  static final _rootNavigatorExpenses = GlobalKey<NavigatorState>();
  static final _rootNavigatorSavings = GlobalKey<NavigatorState>();
  
  static GoRouter router(WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return GoRouter(
    initialLocation: authState.value == null ? initR : '/home',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.toString() == '/signIn' || state.uri.toString() == '/signUp';

      if (!isLoggedIn && !isLoggingIn) {
        return '/signIn';
      }

      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }

      return null;

    },
    routes: <RouteBase>[
      
      GoRoute(
        path: '/signIn',
        name: 'SignIn',
        builder: (context, state) {
          return SignIn(
            key: state.pageKey
          );
        }
      ),

      GoRoute(
        path: '/signUp',
        name: 'SignUp',
        builder: (context, state) {
          return SignUp(
            key: state.pageKey
          );
        }
      ),

      GoRoute(
                path: '/profile',
                name: 'Profile',
                builder: (context, state) {
                  return Profile(
                    key: state.pageKey
                  );
                }
              ),

      GoRoute(
                path: '/notifications',
                name: 'Notifications',
                builder: (context, state) {
                  return Notifications(
                    key: state.pageKey
                  );
                }
              ),

      GoRoute(
        path: '/userCreditCards',
        name: 'UserCreditCards',
        builder: (context, state) {
          return UserCreditCards(
            key: state.pageKey
          );
        }
      ),

      /// Main Navigation Screen
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Navigation(navigationShell: navigationShell,);
        },
        branches: <StatefulShellBranch>[
          /// Branch Home
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/home', 
                name: 'Home',
                builder: (context, state) {
                  return Home(
                    key: state.pageKey,
                  );
                },

                routes: [
                  /// Sub routes
                  GoRoute(
                    path: '/allExpenses',
                    name: "AllExpenses",
                    builder: (context, state) {
                      return AllTransactions(
                        key: state.pageKey
                      );
                    }
                  )
                ]
              )
            ]
          ),

          /// Branch Cards

          StatefulShellBranch(
            navigatorKey: _rootNavigatorCards,
            routes: [
              GoRoute(
                path: '/cards', 
                name: 'Cards',
                builder: (context, state) {
                  return CreditCards(
                    key: state.pageKey,
                  );
                }
              )
            ]
          ),
          
          /// Branch Expenses
          StatefulShellBranch(
            navigatorKey: _rootNavigatorExpenses,
            routes: [
              GoRoute(
                path: '/expenses', 
                name: 'Expenses',
                builder: (context, state) {
                  return Expenses(
                    key: state.pageKey,
                  );
                },

                routes: [
                  /// Sub routes
                  GoRoute(
                    path: '/newCategory',
                    name: "NewCategory",
                    builder: (context, state) {
                      return AddCategory(
                        key: state.pageKey
                      );
                    }
                  )
                ]

              )
            ]
          ),


          /// Branch Savings
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSavings,
            routes: [
              GoRoute(
                path: '/savings', 
                name: 'Savings',
                builder: (context, state) {
                  return SavingsAccounts(
                    key: state.pageKey,
                  );
                }
              )
            ]
          )

        ]
      )

    ],
  );
  }

  /// Go Router Configuration
  

}