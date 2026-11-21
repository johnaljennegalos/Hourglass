import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/dashboard/widgets/dashboard_header.dart';
import 'package:hourglass/views/pages/student/dashboard/widgets/booking_stat_grid.dart';
import 'package:hourglass/views/pages/student/dashboard/widgets/recent_activity_card.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/services/student_service.dart';
import 'package:hourglass/views/pages/student/student_bookings/student_bookings_page.dart';

class StudentDashboardPage extends StatefulWidget {
  final VoidCallback? onViewAllActivity;
  const StudentDashboardPage({super.key, this.onViewAllActivity,});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  List<ConsultationBooking> _bookings = [];
  Map<String, dynamic> _metrics = {};
  bool _isLoading = true;
  String? _errorMessage;
  String _studentName = '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      
      final results = await Future.wait([
        StudentService.getProfile(),
        StudentService.getBookingHistory()
      ]);

      if (!mounted) return;

      final profile = results[0] as Map<String, dynamic>?;
      final student = profile?['student'] as Map<String, dynamic>?;
      final metrics = profile?['metrics'] as Map<String, dynamic>?;
      print(metrics);
      final fetchedBookings = results[1] as List<ConsultationBooking>?;

      setState(() {
        _bookings = fetchedBookings ?? [];
        _studentName = student?['first_name'] ?? (_bookings.isNotEmpty ? _bookings.first.firstName : '');
        _metrics = metrics ?? {};
        _avatarUrl = student?['avatar'] ?? (_bookings.isNotEmpty ? _bookings.first.studentAvatar : null);
        _isLoading = false;
      });
      
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = 'Failed to load dashboard data. Please try again.';
        _isLoading = false;
      });
    }
  }

  List<ConsultationBooking> _recentBookings() {
    final sorted = List<ConsultationBooking>.from(_bookings)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(4).toList();
  }

  int get _pendingCount =>
      _bookings.where((b) => b.status.toUpperCase() == 'PENDING').length;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(studentName: _studentName, avatarUrl: _avatarUrl,),
              SizedBox(height: 20),
              BookingStatGrid(totalConsultations: _metrics['total_consultations'] ?? 0, incomingConsultations: _metrics['incoming_consultations'] ?? 0, completedConsultations: _metrics['completed_consultations'] ?? 0, pendingConsultations: _pendingCount ?? 0),
              SizedBox(height: 20),
              RecentActivityCard(recentBookings: _recentBookings(), onViewAll: widget.onViewAllActivity,)
            ],
          ),
        ),
      ),
    );
  }
}
