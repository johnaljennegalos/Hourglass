import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/student_bookings/widgets/booking_card.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/services/student_service.dart';
import 'package:intl/date_symbols.dart';

class StudentBookingsPage extends StatefulWidget {
  const StudentBookingsPage({super.key});

  @override
  State<StudentBookingsPage> createState() => _StudentBookingsPageState();
}

class _StudentBookingsPageState extends State<StudentBookingsPage> {
  List<ConsultationBooking> _allBookings = [];
  List<ConsultationBooking> _filteredBookings = [];
  bool _isLoading = true;
  String? errorMessage;
  List<String> _activeFilterIndex = ['ALL', 'PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED'];
  String _selectedFilter = 'ALL';

  void _applyFilter(String status) {
    if (status == 'ALL') {
      _filteredBookings = List.from(_allBookings);
    } else {
      _filteredBookings = _allBookings.where((booking) => booking.status.toUpperCase() == status.toUpperCase()).toList();
    }
  }


  Future<void> _fetchBookings() async {

    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {

      final bookings = await StudentService.getBookingHistory();

      if (!mounted) return;

      setState(() {
        if (bookings != null && bookings.isNotEmpty) {
          _allBookings = bookings ?? [];

          _applyFilter(_selectedFilter);

          _isLoading = false;
        }
      });

    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Failed to load bookings. Please check your network connection and try again.';
        _isLoading = false;
      });
    }
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
       children: _activeFilterIndex.map((filter) {
         final isSelected = _selectedFilter == filter;
         return Padding(
           padding: const EdgeInsets.only(right: 8.0),
           child: ChoiceChip(
             label: Text(filter),
             selected: isSelected,
             onSelected: (selected) {
               if (selected) {
                 setState(() {
                   _selectedFilter = filter;
                   _applyFilter(filter);
                 });
               }
             },
           ),
         );
       }).toList(),
      ),
    );
  }

  Widget _buildBookingContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Text(
              errorMessage!,
              style: TextStyle(
                color: Colors.red
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _fetchBookings,
                child: const Text('Retry')
            )
          ],
        ),
      );
    }

    if (_filteredBookings.isEmpty){
      return Center(
        child: Text('No $_selectedFilter bookings found.'),
      );
    }

    return RefreshIndicator(
        onRefresh: _fetchBookings,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _filteredBookings.length,
          itemBuilder: (context, index) {
            final booking = _filteredBookings[index];
            return BookingCard(
              booking: booking,
              onCancel: () => _handleCancelBooking(booking.id),
            );
          },
        ),
    );
  }

  Future<void> _handleCancelBooking(int bookingId) async {
    final confirm = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Cancel Booking'),
      content: const Text('Are you sure you want to cancel this consultation booking?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));

    if (confirm == true) {
      try{
        final success = await StudentService.cancelBooking(bookingId);

        if (!mounted) return;


        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking cancelled successfully.')),
          );

          _fetchBookings();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to cancel booking. Please try again.')),
          );
        }
      } catch (e) {

      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }


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
              _buildFilterChips(),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildBookingContent(),
                    Center(child: Text('History')),
                  ],
                ),
              ),
              //add a button 'Book new appointment'
            ],
          ),
        ),
      ),
    );
  }
}
