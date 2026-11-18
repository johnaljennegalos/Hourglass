import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:hourglass/views/pages/student/book_slot/book_slot.dart';
import 'package:hourglass/views/pages/student/home/student_home.dart';
import 'package:hourglass/views/pages/student/profile/student_profile.dart';
import 'package:hourglass/views/pages/student/student_bookings/student_bookings_page.dart';
import 'package:hourglass/views/pages/student/notifications/student_notifications_page.dart';
import 'package:hourglass/views/pages/student/notifications/widgets/notification_badge_icon.dart';
import 'package:hourglass/services/notification_service.dart';
import 'package:hourglass/views/pages/student/dashboard/student_dashboard_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  int _selectedIndex = 0;
  int _unreadCount = 0;
  int _bookingsInitialTab = 0;

  final GlobalKey<CurvedNavigationBarState> _navBarKey = GlobalKey();

  void _openBookingsTab({int tabIndex = 0}) {
    setState(() {
      _bookingsInitialTab = tabIndex;
      _selectedIndex = 2;
    });
    _navBarKey.currentState?.setPage(2);
  }

  final List<Widget> _pages = [
    const Center(child: StudentDashboardPage()),
    const Center(child: BookSlot()),
    const Center(child: StudentBookingsPage()),
    const Center(child: StudentNotificationsPage()),
    const Center(child: StudentProfile()),
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
    final pages = <Widget>[
      StudentDashboardPage(
        onViewAllActivity: () => _openBookingsTab(tabIndex: 1),
      ),
      const BookSlot(),
      StudentBookingsPage(
        key: ValueKey(_bookingsInitialTab),
        initialTabIndex: _bookingsInitialTab,
      ),
      const StudentNotificationsPage(),
      const StudentProfile(),
    ];

    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: Text('appbar'),
      //   actions: [
      //     NotificationBadgeIcon(
      //       unreadCount: _unreadCount,
      //     )
      //   ],
      // ),
      body: pages[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        key: _navBarKey,
        index: 0,
        height: 60,
        iconPadding: 12,
        color: const Color(0xFF2563EB),
        buttonBackgroundColor: const Color(0xFF1E40AF),
        backgroundColor: Colors.transparent,
        items: <CurvedNavigationBarItem>[
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
            child: NotificationBadgeIcon(unreadCount: _unreadCount, isSelected: _selectedIndex == 3,),
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
            if (index == 2) {
              _bookingsInitialTab = 0;
            }
            _selectedIndex = index;
          });
        },),
    );
  }
}
