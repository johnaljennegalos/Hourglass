import 'package:flutter/material.dart';


class InstructorBookingPage extends StatefulWidget {
  const InstructorBookingPage({super.key});

  @override
  State<InstructorBookingPage> createState() => _InstructorBookingPageState();
}

class _InstructorBookingPageState extends State<InstructorBookingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'PENDING'),
                  Tab(text: 'CONFIRMED'),
                  Tab(text: 'HISTORY'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('PENDING')),
                    Center(child: Text('CONFIRMED')),
                    Center(child: Text('HISTORY')),
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
