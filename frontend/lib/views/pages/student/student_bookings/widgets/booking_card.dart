import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  const BookingCard({super.key});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(),
                //instructors info
                //status Badge
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
