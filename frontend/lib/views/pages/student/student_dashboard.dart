import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:hourglass/views/pages/student/book_slot/book_slot.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  int _selectedIndex = 0;

  final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

  final List<Widget> _pages = [
    const Center(child: Text('Home')),
    const Center(child: BookSlot()),
    const Center(child: Text('My Bookings')),
    const Center(child: Text('Notifications')),
    const Center(child: Text('Profile')),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        key: _navBarKey,
        index: 0,
        height: 60,
        iconPadding: 12,
        color: const Color(0xFF2563EB),
        buttonBackgroundColor: const Color(0xFF1E40AF),
        backgroundColor: Colors.transparent,
        items: const <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: Icon(Icons.home_rounded, size: 30, color: Colors.white),
            // label: 'Home',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add_circle_rounded, size: 30, color: Colors.white),
            // label: 'Book Slot',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_month_rounded, size: 30, color: Colors.white),
            // label: 'My Bookings',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.notifications_rounded, size: 30, color: Colors.white),
            // label: 'Notifications',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, size: 30, color: Colors.white),
            // label: 'Profile',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },),
    );
  }
}
