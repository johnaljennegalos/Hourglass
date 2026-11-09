import 'package:flutter/material.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/services/instructor_service.dart';
import 'package:hourglass/views/pages/instructor/instructor_bookings/widgets/instructor_booking_card.dart';


class InstructorBookingPage extends StatefulWidget {
  const InstructorBookingPage({super.key});

  @override
  State<InstructorBookingPage> createState() => _InstructorBookingPageState();
}

class _InstructorBookingPageState extends State<InstructorBookingPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final InstructorService _instructorService = InstructorService();
  bool _isLoading = true;
  List<ConsultationBooking> _pendingBookings = [];
  List<ConsultationBooking> _confirmedBookings = [];
  List<ConsultationBooking> _historyBookings = [];


  Future<void> _fetchBookings() async {
    setState(() {
      _isLoading = true;
    });

    try{
      if (!mounted) return;

      final bookings = await _instructorService.getInstructorBookings();

      setState(() {
        _pendingBookings.clear();
        _confirmedBookings.clear();
        _historyBookings.clear();

          if (bookings != null && bookings.isNotEmpty){
            for (var book in bookings) {
              if (book.status.toUpperCase() == 'PENDING') {
                _pendingBookings.add(book);
              } else if (book.status.toUpperCase() == 'CONFIRMED') {
                _confirmedBookings.add(book);
              } else if (['COMPLETED', 'REJECTED', 'CANCELLED'].contains(book.status.toUpperCase())) {
                _historyBookings.add(book);
              }
          }
        }
      });

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load bookings.')),
      );

    } finally {
      if (!mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleReject(ConsultationBooking booking) async {
    TextEditingController _reasonInput = TextEditingController();

    final String? rejectionReason = await showDialog<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            _reasonInput.addListener(() {
              setDialogState(() {});
            });

            return AlertDialog(
              title: const Text('Reject Booking'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _reasonInput,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Provide a reason for rejecting this booking...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _reasonInput.text.trim().isNotEmpty
                      ? () {
                    String enteredText = _reasonInput.text.trim();
                    Navigator.pop(context, enteredText);
                  }
                      : null,
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      }

    );

    _reasonInput.dispose();

    if(rejectionReason != null && rejectionReason.isNotEmpty) {
      try{

        await _instructorService.rejectBooking(booking.id, rejectionReason);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking rejected successfully')),
        );

        _fetchBookings();

      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reject booking: $e')),
        );
      }
    }
  }

  Future<void> _handleApprove(ConsultationBooking booking) async {

    try {
      await _instructorService.approveBooking(booking.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking approved successfully')),
      );

      _fetchBookings();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve booking: $e')),
      );
    }

  }


  Future<void> _handleMarkAttendance(ConsultationBooking booking) async {

    try {

      await _instructorService.markAttendance(booking.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance marked successfully')),
      );

      _fetchBookings();

    } catch (e) {

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark attendance: $e')),
      );

    }

  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchBookings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
