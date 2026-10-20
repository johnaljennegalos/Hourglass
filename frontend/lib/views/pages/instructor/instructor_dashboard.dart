import 'package:flutter/material.dart';

class InstructorDashboard extends StatefulWidget {
  const InstructorDashboard({super.key});

  @override
  State<InstructorDashboard> createState() => _InstructorDashboardState();
}

class _InstructorDashboardState extends State<InstructorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructor'),
      ),
    );
  }
}
