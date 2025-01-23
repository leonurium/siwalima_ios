import 'package:flutter/material.dart';
import '../config/app_constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: AppConstans.navMenu.map((e) => e['view'] as Widget).toList(),
      ),
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,                     
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconSize: 26,
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTap,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey[400],
              items: AppConstans.navMenu.map((e) {
                return BottomNavigationBarItem(
                  icon: Icon(e['icon']),
                  label: e['label'],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
