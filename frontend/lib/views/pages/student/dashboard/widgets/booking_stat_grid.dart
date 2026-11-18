import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/dashboard/widgets/booking_stat_card.dart';

class BookingStatGrid extends StatelessWidget {
  final int totalConsultations;
  final int incomingConsultations;
  final int completedConsultations;
  final int pendingConsultations;

  const BookingStatGrid({super.key, required this.totalConsultations, required this.incomingConsultations, required this.completedConsultations, required this.pendingConsultations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BookingStatCard(
                title: 'Total',
                value: totalConsultations,
                iconData: Icons.calendar_today_rounded,
                accentColor: Colors.blue
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: BookingStatCard(
                title: 'Incoming',
                value: incomingConsultations,
                iconData: Icons.schedule_rounded,
                accentColor: Colors.amber.shade700
              ),
            )
          ],
        ),
        SizedBox(width: 10,),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              child: BookingStatCard(
                title: 'Completed',
                value: completedConsultations,
                iconData: Icons.check_circle_outline_rounded,
                accentColor: Colors.green
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: BookingStatCard(
                title: 'Pending',
                value: pendingConsultations,
                iconData: Icons.hourglass_top_rounded,
                accentColor: Colors.orange
              ),
            )
          ],
        ),
      ],
    );
  }
}
