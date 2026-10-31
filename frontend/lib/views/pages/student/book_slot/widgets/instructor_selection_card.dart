import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/models/instructor_model.dart';

class InstructorSelectionCard extends StatelessWidget {
  final InstructorModel instructor;
  final bool isSelected;
  final VoidCallback onTap;
  const InstructorSelectionCard({super.key, required this.instructor, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundImage: instructor.avatarUrl != null && instructor.avatarUrl!.isNotEmpty
                ? NetworkImage(instructor.avatarUrl!)
                : null,
              child: instructor.avatarUrl == null || instructor.avatarUrl!.isEmpty
                  ? Text(
                instructor.name.isNotEmpty ? instructor.name[0].toUpperCase() : '?',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
                  : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(instructor.name, style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                  Text(instructor.department, style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),),
                  Text(instructor.specialization, style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),)
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey, size: 22.0,
            ),
          ],
        ),
      ),
    );
  }
}

