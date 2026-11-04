import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/student_bookings/widgets/booking_card.dart';

class StudentBookingsPage extends StatefulWidget {
  const StudentBookingsPage({super.key});

  @override
  State<StudentBookingsPage> createState() => _StudentBookingsPageState();
}

class _StudentBookingsPageState extends State<StudentBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Upcoming / Active'),
                  Tab(text: 'History'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('Upcoming / Active')),
                    Center(child: Text('History')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
