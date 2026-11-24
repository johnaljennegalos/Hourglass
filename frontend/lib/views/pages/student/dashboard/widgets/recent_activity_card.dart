import 'package:flutter/material.dart';
import 'package:hourglass/models/consultation_booking.dart';
import 'package:intl/intl.dart';

class RecentActivityCard extends StatelessWidget {
  final List<ConsultationBooking> recentBookings;
  final VoidCallback? onViewAll;
  const RecentActivityCard({super.key, required this.recentBookings, this.onViewAll});

  (Color, IconData) _statusStyle(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return (Colors.green, Icons.check_circle_outline_rounded);
      case 'CONFIRMED':
        return (Color(0xFF2563EB), Icons.event_available_rounded);
      case 'CANCELLED':
      case 'REJECTED':
        return (Colors.redAccent, Icons.cancel_outlined);
      case 'PENDING':
      default:
        return (Color(0xFFD97706), Icons.schedule_rounded);
    }
  }

  String _formatDate(String rawDate) {
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    return DateFormat('MMM d, y • h:mm a').format(parsed.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              if (onViewAll != null) ...[
                GestureDetector(
                  onTap: onViewAll,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
          const SizedBox(height: 14),
          if (recentBookings.isEmpty) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history_rounded),
                    const SizedBox(width: 8),
                    Flexible(child: Text('No recent consultation activity yet.'))
                  ],
                ),
              ),
            )
          ],
          if (recentBookings.isNotEmpty) ...[
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => Divider(height: 20, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final booking = recentBookings[index];
                final (statusColor, statusIcon) = _statusStyle(booking.status);
                final teacherName = '${booking.slot.teacher.firstName} ${booking.slot.teacher.lastName}'.trim();
                final title = teacherName.isNotEmpty ? teacherName : 'Consultation #${booking.id}';
                final hasReason = booking.reason != null && booking.reason!.trim().isNotEmpty;
                final subtitle = hasReason ? booking.reason!.trim() : '${booking.slot.date} • ${booking.slot.startTime}';
                final date = _formatDate(booking.createdAt);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const SizedBox(width: 12),
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
                            overflow: TextOverflow.ellipsis
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade600
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade600
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        booking.status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: recentBookings.length,
            )
          ]
        ],
      ),
    );
  }
}
