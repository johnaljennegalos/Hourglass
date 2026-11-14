import 'package:flutter/material.dart';
import 'package:hourglass/models/notification_model.dart';

class NotificationTile extends StatelessWidget {

  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({super.key, required this.notification, required this.onTap});

  String _formatTimeAgo(DateTime datetime) {
    final diff = DateTime.now().difference(datetime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${datetime.month}/${datetime.day}/${datetime.year}';
  }

  @override
  Widget build(BuildContext context) {

    final isUnread = !notification.isRead;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: isUnread ? 2 : 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUnread ? BorderSide(color: primaryColor.withValues(alpha: 0.25)) : BorderSide.none,
      ),
      color: isUnread ? Colors.blue.withValues(alpha: 0.06) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isUnread ? primaryColor.withValues(alpha: 0.25) : Colors.grey.withValues(alpha: 0.15),
                child: Icon(
                  notification.bookingDetails != null ? Icons.calendar_today : Icons.notifications_none,
                  size: 20,
                  color: isUnread ? primaryColor : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          _formatTimeAgo(notification.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: isUnread ? primaryColor : Colors.grey[500]
                          ),
                        ),
                        if (isUnread) ...[
                          SizedBox(width: 6,),
                          Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey[700]
                      ),
                    ),
                    if (notification.bookingDetails != null) ...[
                      SizedBox(height: 8,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.event_note,
                              size: 14,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Booking #${notification.bookingDetails!.slotDate} • ${notification.bookingDetails!.status}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
