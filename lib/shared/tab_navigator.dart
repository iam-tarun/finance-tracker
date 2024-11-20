import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => page);
      },
    );
  }
}