import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AvailableSlotSection extends StatefulWidget {
  const AvailableSlotSection({super.key});

  @override
  State<AvailableSlotSection> createState() => _AvailableSlotSectionState();
}

class _AvailableSlotSectionState extends State<AvailableSlotSection> {
  DateTime displayedMonth = DateTime.now();
  int get daysInMonth =>
      DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Select Month & Year'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          displayedMonth = DateTime(
                            displayedMonth.year,
                            displayedMonth.month - 1,
                          );
                        });
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${DateFormat('MMMM yyyy').format(displayedMonth)}',
                            style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        setState(() {
                          displayedMonth = DateTime(
                            displayedMonth.year,
                            displayedMonth.month - 1,
                          );
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
                  ].map((day) => Expanded(
                    child: Center(child: Text(day)),
                  )).toList(),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    final day = index + 1;

                    return InkWell(
                      onTap: null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE2E8F0)
                          )
                        ),
                        child: Text(
                          '$day',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
