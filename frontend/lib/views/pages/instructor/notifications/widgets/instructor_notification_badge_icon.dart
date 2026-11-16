import 'package:flutter/material.dart';


class InstructorNotificationBadgeIcon extends StatelessWidget {
  final int unreadCount;
  final bool isSelected;

  const InstructorNotificationBadgeIcon({super.key, required this.unreadCount, this.isSelected = false});


  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: unreadCount > 0,
      label: Text(unreadCount > 99 ? '+99' : '$unreadCount', style: const TextStyle(color: Colors.white, fontSize: 10),),
      backgroundColor: Colors.red,
      child: Icon(isSelected ? Icons.notifications_rounded : Icons.notifications_outlined, size: 30, color: Colors.white,),
    );
  }
}
