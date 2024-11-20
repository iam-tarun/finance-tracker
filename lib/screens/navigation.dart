import 'package:finance_tracker/screens/add_expense.dart';
import 'package:finance_tracker/shared/custom_text.dart';
import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    super.key,
    required this.navigationShell
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>  {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _goToBranch(_selectedIndex);
  }

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
  

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 10.0,
      builder: (context) => const AddExpense(),
      );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleSmall('Finance Tracker'),
        leading: IconButton(
          onPressed: () {
            context.pushNamed('Profile');
          }, 
          icon: const Icon(Icons.person_2),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed('Notifications');
            },
            icon: const Icon(Icons.notifications),
            ),  
        ],
        
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell
      ),
      // )    _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: 'savings',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'addExpenseButton',
        onPressed: _showAddExpenseSheet,
        backgroundColor: AppColors.primaryColor,
        shape: ShapeBorder.lerp(const CircleBorder(), const CircleBorder(), 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}