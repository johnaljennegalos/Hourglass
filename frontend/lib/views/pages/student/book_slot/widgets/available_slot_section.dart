import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/section_header.dart';
import 'package:hourglass/views/pages/student/book_slot/models/slot_model.dart';

class AvailableSlotSection extends StatefulWidget {
  final String? instructorId;
  final Function(DateTime date, String slotId)? onSlotSelected;
  const AvailableSlotSection({super.key, required this.instructorId, required this.onSlotSelected});

  @override
  State<AvailableSlotSection> createState() => _AvailableSlotSectionState();
}

class _AvailableSlotSectionState extends State<AvailableSlotSection> {
  DateTime displayedMonth = DateTime.now();
  DateTime? selectedDate;
  String? _selectedSlotId;
  List<SlotModel> _availableSlots = [];
  bool _isLoading = false;

  int get blankSpaces =>
      DateTime(displayedMonth.year, displayedMonth.month, 1).weekday % 7;

  int get totalDaysInMonth =>
      DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(step: 2, title: 'Select Available Slot'),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Select Month & Year'),
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
                          DateFormat('MMMM yyyy').format(displayedMonth),
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
                            displayedMonth.month + 1,
                          );
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Days of Week Header
                Row(
                  children: [
                    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
                  ].map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 10),
                // Calendar Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: blankSpaces + totalDaysInMonth,
                  itemBuilder: (context, index) {
                    if (index < blankSpaces) {
                      return const SizedBox.shrink();
                    }

                    final int dayNumber = index - blankSpaces + 1;

                    final DateTime currentCellDate = DateTime(
                      displayedMonth.year,
                      displayedMonth.month,
                      dayNumber,
                    );

                    final bool isSelected = selectedDate?.year == currentCellDate.year &&
                        selectedDate?.month == currentCellDate.month &&
                        selectedDate?.day == currentCellDate.day;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDate = currentCellDate;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Theme.of(context).primaryColor : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          '$dayNumber',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
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
