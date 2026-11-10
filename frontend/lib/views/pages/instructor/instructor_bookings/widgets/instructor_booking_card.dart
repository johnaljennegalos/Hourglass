import 'package:flutter/material.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:intl/intl.dart';

class InstructorBookingCard extends StatefulWidget {
  final ConsultationBooking booking;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onMarkAttendance;

  const InstructorBookingCard({super.key, required this.booking, this.onApprove, this.onMarkAttendance, this.onReject});

  @override
  State<InstructorBookingCard> createState() => _InstructorBookingCardState();
}

class _InstructorBookingCardState extends State<InstructorBookingCard> {
  Color _getStatusBackgroundColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.amber.shade100;
      case 'CONFIRMED':
        return Colors.blue.shade100;
      case 'COMPLETED':
        return Colors.green.shade100;
      case 'REJECTED':
      case 'CANCELLED':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.amber.shade900;
      case 'CONFIRMED':
        return Colors.blue.shade900;
      case 'COMPLETED':
        return Colors.green.shade900;
      case 'REJECTED':
      case 'CANCELLED':
        return Colors.red.shade900;
      default:
        return Colors.grey.shade800;
    }
  }

  String formatTimeIntl(String timeStr) {
    try {
      final DateTime parsedTime = DateFormat('HH:mm:ss').parse(timeStr);
      return DateFormat('h:mm a').format(parsedTime); // e.g. "1:00 PM"
    } catch (e) {
      return timeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 4.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: (widget.booking.studentAvatar != null && widget.booking.studentAvatar!.isNotEmpty)
                            ? NetworkImage(widget.booking.studentAvatar!)
                            : null,
                  child: (widget.booking.studentAvatar == null || widget.booking.studentAvatar!.isEmpty)
                            ? Text(
                              widget.booking.firstName.isNotEmpty
                                  ? widget.booking.firstName[0].toUpperCase()
                                  : 'S',
                            )
                           : null
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Text('${widget.booking.firstName} ${widget.booking.lastName}', style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Text(
                        widget.booking.studentEmail,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusBackgroundColor(widget.booking.status),
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Text(
                    widget.booking.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusTextColor(widget.booking.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                )
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey,),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Text(
                        '${widget.booking.slot.date} • ${formatTimeIntl(widget.booking.slot.startTime)} - ${formatTimeIntl(widget.booking.slot.endTime)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: Text(
                        widget.booking.slot.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87
                        ),
                      ),
                    )
                  ],
                ),
                if (widget.booking.reason != null && widget.booking.reason!.trim().isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Colors.grey.shade400, width: 3))
                    ),
                    child: Text(
                      'Student Note: ${widget.booking.reason}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black87
                      ),
                    ),
                  )
                ],
                if (widget.booking.status.toUpperCase() == 'REJECTED' && widget.booking.rejectionReason != null && widget.booking.rejectionReason!.trim().isNotEmpty) ...[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.red.shade700,),
                        Text('Rejection reason: ${widget.booking.rejectionReason}')
                      ],
                    ),
                  )
                ],
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.booking.status.toUpperCase() == 'PENDING') ...[
                  OutlinedButton(
                    onPressed: () {
                      widget.onReject?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text(
                      'Reject Booking',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      widget.onApprove?.call();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.greenAccent,
                      side: const BorderSide(color: Colors.greenAccent, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text(
                      'Approve Booking',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                if (widget.booking.status.toUpperCase() == 'CONFIRMED') ...[
                  ElevatedButton(
                    onPressed: () {
                      widget.onMarkAttendance?.call();
                    },
                    child: const Text('Mark Attendance'),
                  )
                ],
                if(widget.booking.status.toUpperCase() == 'COMPLETED' || widget.booking.status.toUpperCase() == 'REJECTED' || widget.booking.status.toUpperCase() == 'CANCELLED') ...[
                  SizedBox.shrink()
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
