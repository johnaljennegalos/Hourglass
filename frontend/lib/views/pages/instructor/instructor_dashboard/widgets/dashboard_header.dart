import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {

  final String instructorName;
  final String? avatarUrl;
  final VoidCallback? onAvatarTap;

  const DashboardHeader({super.key, required this.instructorName, this.avatarUrl, this.onAvatarTap});

  String _getDisplayedName() {
    final trimName = instructorName.trim();
    final name = (trimName.isNotEmpty) ? trimName : 'Instructor';
    return name;
  }

  String _getInitial(){
    final initial = _getDisplayedName()[0].toUpperCase();
    return initial;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAvatar = avatarUrl != null && avatarUrl!.trim().isNotEmpty;


    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome, ${_getDisplayedName()}', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ), maxLines: 1, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 4,),
              Text(
                'Here is what is happening on your account',
                style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: Colors.blue,
            backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,
            onBackgroundImageError: hasAvatar ? (_, __) {} : null,
            child: !hasAvatar ? Text(
              _getInitial(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ) : null,
          ),
        )
      ],
    );
  }
}
