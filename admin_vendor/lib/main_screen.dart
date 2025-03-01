import 'package:admin_vendor/view/sidebar/profile/profile_page.dart';
import 'package:admin_vendor/view/sidebar/services/services_screen.dart';
import 'package:flutter/material.dart';

import 'view/sidebar/aboutus/about_us_screen.dart';
import 'view/sidebar/dashboard/dashboard_screen copy.dart';
import 'view/sidebar/order/order_screen.dart';
import 'view/sidebar/transaction/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    TransactionScreen(),
    const OrdersScreen(),
    ServicesScreen(),
    ProfilePage(),
    const AboutUsScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.dashboard_outlined, label: 'Dashboard'),
    NavigationItem(icon: Icons.receipt_long_outlined, label: 'Transaction'),
    NavigationItem(icon: Icons.task_outlined, label: 'Order'),
    NavigationItem(icon: Icons.design_services, label: 'Service'),
    NavigationItem(icon: Icons.person_outline, label: 'Profile'),
    NavigationItem(icon: Icons.info_outline, label: 'About Us'),
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              backgroundColor: const Color(0xFF121212),
              foregroundColor: Colors.white,
              title: Text(_navigationItems[_selectedIndex].label),
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
          : null, // Show AppBar only for Mobile
      body: Row(
        children: [
          if (!isMobile)
            _buildSidebar(), // Show Sidebar only for Tablet/Desktop
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      drawer: isMobile ? _buildDrawer() : null, // Show Drawer only for Mobile
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: const Color(0xFF121212),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(
            'assets/logo.png', // Replace with your logo
            height: 60,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _navigationItems[index].icon,
                    color: _selectedIndex == index ? Colors.blue : Colors.white,
                  ),
                  title: Text(
                    _navigationItems[index].label,
                    style: TextStyle(
                      color:
                          _selectedIndex == index ? Colors.blue : Colors.white,
                      fontWeight: _selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 60,
                ),
                const SizedBox(height: 10),
                const Text(
                  'App Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _navigationItems[index].icon,
                    color: _selectedIndex == index ? Colors.blue : Colors.white,
                  ),
                  title: Text(
                    _navigationItems[index].label,
                    style: TextStyle(
                      color:
                          _selectedIndex == index ? Colors.blue : Colors.white,
                      fontWeight: _selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  selected: _selectedIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.pop(context); // Close Drawer after selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  NavigationItem({required this.icon, required this.label});
}
