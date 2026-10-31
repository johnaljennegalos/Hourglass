import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final int step;

  const SectionHeader({
    super.key,
    required this.title,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(
            color: Color(0xFF2563EB),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$step',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172554),
            ),
          ),
        )
      ],
    );
  }
}
