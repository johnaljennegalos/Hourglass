import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/instructor_slot.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';


class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Notifs Page')),
    const Center(child: Text('Bookings Page')),
    const Center(child: InstructorSlot()),
    const Center(child: Text('Profile Page')),
    const Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B82F6),
        title: Text('HOURGLASS', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white70),),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        color: const Color(0xFF2563EB),
        buttonBackgroundColor: const Color(0xFF1E40AF),
        backgroundColor: Colors.transparent,
        items: const <CurvedNavigationBarItem>[
            CurvedNavigationBarItem(
              child: Icon(Icons.notifications, size: 30, color: Colors.white),
              label: 'Notifs',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.calendar_today, size: 30, color: Colors.white),
              label: 'Bookings',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.add_circle, size: 30, color: Colors.white),
              label: 'Slots',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.person, size: 30, color: Colors.white),
              label: 'Profile',
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