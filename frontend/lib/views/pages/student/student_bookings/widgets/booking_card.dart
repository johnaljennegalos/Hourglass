import 'package:flutter/material.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/models/teacher_info.dart';

class BookingCard extends StatefulWidget {
  final ConsultationBooking booking;
  final VoidCallback? onCancel;

  const BookingCard({Key? key, required this.booking, this.onCancel}) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return Colors.green.shade700;
      case 'PENDING':
        return Colors.orange.shade800;
      case 'CANCELLED':
        return Colors.grey.shade600;
      case 'REJECTED':
        return Colors.red.shade700;
      case 'COMPLETED':
        return Colors.blue.shade700;
      default:
        return Colors.grey.shade800;
    }
  }

  Widget _buildStatusBadge() {
    final status = widget.booking.status;
    final upperStatus = status.toUpperCase();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getStatusColor(status).withOpacity(0.4))
      ),
      child: Text(
        upperStatus,
        style: TextStyle(
          color: _getStatusColor(status),
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),
      ),
    );


  }

  Widget _buildTeacherAvatar(TeacherInfo teacher) {
    final hasAvatar = teacher.avatarUrl != null && teacher.avatarUrl!.isNotEmpty;

    return CircleAvatar(
      radius: 24,
      backgroundImage: hasAvatar ? NetworkImage(teacher.avatarUrl!) : null,
      child: !hasAvatar ? Text(teacher.firstName!.isNotEmpty ? teacher.firstName[0].toUpperCase(): 'T', style: const TextStyle(
        fontWeight: FontWeight.bold
      ),) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacher = widget.booking.slot.teacher;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildTeacherAvatar(teacher),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (teacher.department != null && teacher.department!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          teacher.department!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600
                          ),
                        ),
                      ],
                      if (teacher.specialization != null && teacher.specialization!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          teacher.specialization!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade500
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                _buildStatusBadge()
              ],
            ),
            Row(
              children: [
                //calendar Icon + date
                //clock icon + time
              ],
            ),
            Divider(),
            Row(
              children: [
                //message icon
                //consultation reason
              ],
            ),
            Row(
              children: [
                //view details button
                //Cancel Booking button (optional)
              ],
            )
          ],
        ),
      ),
    );

    //add a button 'Book new appointment'
  }
}
