

import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/student_bookings/widgets/booking_card.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/services/student_service.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';

class StudentBookingsPage extends StatefulWidget {
  final int initialTabIndex;

  const StudentBookingsPage({super.key, this.initialTabIndex = 0});

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
    final activeBooking = _allBookings.where((b) => (b.status.toUpperCase() == 'PENDING' || b.status.toUpperCase() == 'CONFIRMED')).toList();

    final historyBooking = _allBookings.where((b) => b.isPastSlot || (b.status.toUpperCase() == 'COMPLETED' || b.status.toUpperCase() == 'CANCELLED' || b.status.toUpperCase() == 'REJECTED')).toList();

    if (status == 'ALL') {
      _filteredBookings = activeBooking;
    } else {
      _filteredBookings = activeBooking.where((b) => b.status.toUpperCase() == status.toUpperCase()).toList();
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

        }

        _isLoading = false;
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

  List<ConsultationBooking> get _historyBookings {
    final history = _allBookings.where((b) {
      final s = b.status.toUpperCase();
      return b.isPastSlot || s == 'COMPLETED' || s == 'CANCELLED' || s == 'REJECTED';
    }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (_selectedFilter == 'ALL') return history;
    return history
        .where((b) => b.status.toUpperCase() == _selectedFilter)
        .toList();
  }

  (Color, IconData) _statusStyle(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return (Colors.green, Icons.check_circle_outline_rounded);
      case 'CONFIRMED':
        return (Colors.blue, Icons.event_available_rounded);
      case 'CANCELLED':
      case 'REJECTED':
        return (Colors.redAccent, Icons.cancel_outlined);
      case 'PENDING':
      default:
        return (Colors.amber.shade700, Icons.schedule_rounded);
    }
  }

  String _formatDate(String rawDate) {
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    return DateFormat('MMM d, y • h:mm a').format(parsed.toLocal());
  }

  Widget _buildHistoryContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(),);
    }

    final history = _historyBookings;

    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history_rounded, color: Colors.grey.shade400),
              const SizedBox(width: 8,),
              Text(
                'No consultation history found.',
                style: TextStyle(
                  color: Colors.grey.shade600
                ),
              )
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchBookings,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 90.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.0,
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final history = _historyBookings[index];
              final (statusColor, statusIcon) = _statusStyle(history.status);
              final teacherName = ('${history.slot.teacher.firstName} ${history.slot.teacher.lastName}').trim();
              final title = teacherName.isNotEmpty ? teacherName : 'Consultation # ${history.id}';
              final subtitle = (history.reason != null && history.reason!.trim().isNotEmpty) ? '${history.reason!.trim()} • ${_formatDate(history.createdAt)}' : _formatDate(history.createdAt);

              return Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 19),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2,),
                        Text(
                          subtitle,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey.shade600
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      history.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor
                      ),
                    ),
                  )
                ],
              );

            },
            separatorBuilder: (context, index) => Divider(height: 20, color: Colors.grey.shade200,),
            itemCount: _historyBookings.length
          ),
        ),
      ),
    );
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
      initialIndex: widget.initialTabIndex,
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
                    _buildHistoryContent()
                  ],
                ),
              ),
              // add a button 'Book new appointment'
            ],
          ),
        ),
      ),
    );
  }
}
