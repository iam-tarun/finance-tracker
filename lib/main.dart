import 'package:finance_tracker/app_navigation.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp.router(
              theme: primaryTheme,
              routerConfig: AppNavigation.router,
    ))
  );
}