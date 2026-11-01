import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/section_header.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection_card.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_search_field.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/available_slot_section.dart';

class BookSlot extends StatefulWidget {
  const BookSlot({super.key});

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  String _searchQuery = '';
  String? _selectedInstructorId;
  DateTime? _selectedDate;
  String? _selectedSlotId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(step: 1, title: 'Select Instructor & Subject',),
                InstructorSearchField(onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },),
                InstructorSelection(searchQuery: _searchQuery, selectedInstructorId: _selectedInstructorId, onInstructorSelected: (instructorId) {
                  setState(() {
                    _selectedInstructorId = instructorId;
                  });

                  print('Selected Instructor: $instructorId');
                },),
                if (_selectedInstructorId != null)
                  AvailableSlotSection(
                    instructorId: _selectedInstructorId!,
                    onSlotSelected: (selectedDate, slotId) {
                      setState(() {
                        _selectedDate = selectedDate;
                        _selectedSlotId = slotId;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
