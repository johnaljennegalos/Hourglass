import 'package:flutter/material.dart';

class BookingStatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData iconData;
  final Color accentColor;
  const BookingStatCard({super.key, required this.title, required this.value, required this.iconData, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(),
        color: Colors.grey.shade200
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              iconData,
              color: accentColor,
            ),
          ),
          SizedBox(height: 12,),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 2,),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
