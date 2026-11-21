import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/instructor_dashboard/widgets/dashboard_header.dart';
import 'package:hourglass/views/pages/instructor/instructor_dashboard/widgets/booking_stat_grid.dart';
import 'package:hourglass/services/instructor_service.dart';
import 'package:hourglass/models/teacher_info.dart';
import 'package:hourglass/models/consultation_booking.dart';



class InstructorDashboardPage extends StatefulWidget {
  const InstructorDashboardPage({super.key});

  @override
  State<InstructorDashboardPage> createState() => _InstructorDashboardPageState();
}

class _InstructorDashboardPageState extends State<InstructorDashboardPage> {
  List<ConsultationBooking> _bookings = [];
  TeacherInfo? _teacherInfo;
  bool _isLoading = true;
  String? _errorMessage;
  String _instructorName = '';
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
        InstructorService.getProfile(),
        InstructorService().getInstructorBookings(),
      ]);

      // print(results);

      if (!mounted) return;

      final profile = results[0] as Map<String, dynamic>?;
      final instructor = profile?['teacher'] as Map<String, dynamic>?;
      if (profile != null) {
        _teacherInfo = TeacherInfo.fromJson(profile);
      }
      final fetchedBookings = results[1] as List<ConsultationBooking>?;

      setState(() {
        _teacherInfo = profile != null ? TeacherInfo.fromJson(profile) : null;
        _bookings = fetchedBookings ?? [];
        _avatarUrl = instructor?['avatar'] ?? (_bookings.isNotEmpty ? _bookings.first.studentAvatar : null);
        _isLoading = false;
      });

    } catch (e) {
      if (!mounted) return;

      // print('Dashboard catch error: $e');

      setState(() {
        _errorMessage = 'Failed to load dashboard data. Please try again.';
        _isLoading = false;
      });
    }
  }

  int get _totalConsultations => _bookings.length;
  int get _incomingCount => _bookings.where((b) => !b.isPastSlot && b.status.toUpperCase() == 'CONFIRMED').length;
  int get _completedConsultations => _bookings.where((b) => b.status.toUpperCase() == 'COMPLETED').length;
  int get _pendingConsultations => _bookings.where((b) => b.status.toUpperCase() == 'PENDING').length;

  // List<ConsultationBooking> _recentBookings() {
  //   final sorted = List<ConsultationBooking>.from(_bookings)
  //     ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //   return sorted.take(4).toList();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(instructorName: _teacherInfo?.firstName ?? '', avatarUrl: _teacherInfo?.avatarUrl,),
              // SizedBox(height: 20),
              BookingStatGrid(totalConsultations: _totalConsultations ?? 0, incomingConsultations: _incomingCount ?? 0, completedConsultations: _completedConsultations ?? 0, pendingConsultations: _pendingConsultations ?? 0),
              // SizedBox(height: 20),
              // RecentActivityCard(recentBookings: _recentBookings(), onViewAll: widget.onViewAllActivity,)
            ],
          ),
        ),
      ),
    );
  }
}
