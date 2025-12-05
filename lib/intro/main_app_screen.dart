import 'package:flutter/material.dart';

import 'Dashboard/calander_page.dart';
import 'Dashboard/home_page.dart';
import 'Dashboard/notfication.dart';
import 'Dashboard/setting_page.dart';

// --- Main Entry Point with Bottom Navigation ---

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  // The 4 main screens based on the bottom nav
  final List<Widget> _screens = [
    const DashboardScreen(),
    const CalendarScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF184E56),
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calendar"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Settings"),
          ],
        ),
      ),
    );
  }
}

// --- 1. Dashboard Screen ---



// --- 2. Calendar Screen ---



// --- 3. Notifications Screen ---



// --- 4. Settings Screen ---


// --- 5. Deadline Details Screen (Updated to match Screenshot) ---

