import 'package:flutter/material.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:hourglass/models/teacher_info.dart';
import 'package:intl/intl.dart';

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

  Widget _buildInfoTile(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionsButton() {
    final status = widget.booking.status.toUpperCase();
    final canCancel = status == 'PENDING' || status == 'CONFIRMED';

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  titlePadding: const EdgeInsets.fromLTRB(20, 20, 12, 8),
                  contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  actionsPadding: const EdgeInsets.fromLTRB(20, 8, 20, 16),

                  title: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Booking Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.grey,
                        tooltip: 'Close',
                      ),
                    ],
                  ),

                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildStatusBadge(),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildTeacherAvatar(widget.booking.slot.teacher),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.booking.slot.teacher.fullName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.booking.slot.teacher.department,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      widget.booking.slot.teacher.specialization,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Schedule Information',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.calendar_today_outlined,
                          widget.booking.slot.date,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.access_time_rounded,
                          _formatTimeRange(
                            widget.booking.slot.startTime,
                            widget.booking.slot.endTime,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.location_on_outlined,
                          widget.booking.slot.location,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.people_alt_outlined,
                          'Max Capacity: ${widget.booking.slot.maxCapacity}',
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Consultation Details',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFDBEAFE),
                            ),
                          ),
                          child: Text(
                            widget.booking.reason ?? 'No reason provided',
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),

                        // Rejection details
                        // Only display this when the booking is declined.
                        // _buildRejectionTile(),
                      ],
                    ),
                  ),
                  actions: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            );
          },
          child: const Text('View Details'),
        ),
        if(canCancel) ...[
          const SizedBox(width: 8,),
          OutlinedButton(
            onPressed: widget.onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)
            ),
            child: const Text('Cancel Booking'),
          ),
        ],
      ],
    );
  }

  String _formatTimeString(String rawTime) {
    try{
      final parsedData = DateFormat('HH:mm:ss').parse(rawTime);
      return DateFormat('h:mm a').format(parsedData);
    } catch (e) {
      return rawTime;
    }
  }

  String _formatTimeRange(String start, String end) {
    return '${_formatTimeString(start)} - ${_formatTimeString(end)}';
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInfoTile(
                  Icons.calendar_today_outlined,
                  widget.booking.slot.date
                ),
                const SizedBox(width: 16),
                _buildInfoTile(
                  Icons.access_time_outlined,
                  _formatTimeRange(
                    widget.booking.slot.startTime,
                    widget.booking.slot.endTime
                  )
                )
              ],
            ),
            Divider(),
            Row(
              children: [
                _buildInfoTile(
                  Icons.message_outlined,
                  widget.booking.reason ?? 'No reason provided',
                ),
                if (widget.booking.status.toUpperCase() == 'REJECTED' ||
                    widget.booking.status.toUpperCase() == 'CANCELLED')
                  _buildInfoTile(
                    Icons.cancel_sharp,
                    (widget.booking.rejectionReason != null && widget.booking.rejectionReason!.trim().isNotEmpty)
                        ? widget.booking.rejectionReason!
                        : 'No rejection reason provided',
                  ),
              ],
            ),
            Row(
              children: [
                //view details button
                //Cancel Booking button (optional)
                const SizedBox(height: 12),
                _buildActionsButton()
              ],
            )
          ],
        ),
      ),
    );

    //add a button 'Book new appointment'
  }
}
