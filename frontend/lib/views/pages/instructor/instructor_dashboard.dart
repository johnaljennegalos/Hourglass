import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/instructor_slot.dart';
import 'package:hourglass/views/pages/instructor/profile/instructor_profile.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:hourglass/views/pages/instructor/instructor_bookings/instructor_booking_page.dart';
import 'package:hourglass/views/pages/instructor/notifications/widgets/instructor_notification_badge_icon.dart';
import 'package:hourglass/views/pages/instructor/notifications/instructor_notification_page.dart';
import 'package:hourglass/services/notification_service.dart';


class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {

  int _selectedIndex = 0;
  int _unreadCount = 0;

  final List<Widget> _pages = [
    const Center(child: InstructorNotificationPage()),
    const Center(child: InstructorBookingPage()),
    const Center(child: InstructorSlot()),
    const Center(child: InstructorProfile()),
  ];

  @override
  void initState(){
    super.initState();
    _fetchUnreadCount();
  }

  Future<void> _fetchUnreadCount() async {
    final count = await NotificationService().getUnreadCount();
    if (!mounted || count ==null) return;
    setState(() {
      _unreadCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        color: const Color(0xFF2563EB),
        buttonBackgroundColor: const Color(0xFF1E40AF),
        backgroundColor: Colors.transparent,
        items: <CurvedNavigationBarItem>[
            CurvedNavigationBarItem(
              child: InstructorNotificationBadgeIcon(unreadCount: _unreadCount, isSelected: _selectedIndex == 3,),
              // label: 'Notifs',
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