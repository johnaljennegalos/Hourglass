import 'package:flutter/material.dart';

class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Bookings Page')),
    const Center(child: Text('Slots Page')),
    const Center(child: Text('Notifs Page')),
    const Center(child: Text('Profile Page')),
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
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFF2563EB),
        indicatorColor: Colors.white24,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );
            }
            return const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            );
          },
        ),
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.notifications_none, color: Colors.white70),
            selectedIcon: Icon(Icons.notifications, color: Colors.white),
            label: 'Notifs',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.calendar_today, color: Colors.white),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.add_circle, color: Colors.white),
            label: 'Slots',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
