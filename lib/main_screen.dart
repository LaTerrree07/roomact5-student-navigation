import 'package:flutter/material.dart';

import 'calculator_screen.dart';
import 'dashboard_page.dart';
import 'demo_auth.dart';
import 'profile_page.dart';
import 'social_media/social_media.dart';

class MainScreen extends StatefulWidget {
  final String? currentUsername;
  final String? username;

  const MainScreen({super.key, this.currentUsername, this.username});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    final username =
        widget.currentUsername ??
        widget.username ??
        DemoAuth.currentUsername ??
        'Student';

    pages = [
      DashboardPage(
        username: username,
        onNavigateTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      const CalculatorScreen(),
      SocialMediaPage(username: username),
      ProfilePage(username: username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
