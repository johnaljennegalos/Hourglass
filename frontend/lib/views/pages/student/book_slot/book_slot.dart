import 'package:flutter/material.dart';
import 'package:hourglass/services/student_service.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/section_header.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection_card.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_search_field.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/available_slot_section.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/consultation_details_section.dart';
import 'package:intl/intl.dart';
import 'package:hourglass/views/pages/student/home/student_home.dart';

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
  bool _isSubmitting = false;

  Future<void> _submitBooking(String reason) async {
    setState(() {
      _isSubmitting = true;
    });

    Map<String, dynamic> bookingData = {
      'instructor': _selectedInstructorId,
      'slot': _selectedSlotId,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'reason': reason
    };

    try{
      await StudentService.createBooking(bookingData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking confirmed successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        _selectedInstructorId = null;
        _selectedDate = null;
        _selectedSlotId = null;
      });

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to complete booking: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }


  }


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
                if (_selectedDate != null && _selectedSlotId != null) ...[
                  const SizedBox(height: 24),
                  ConsultationDetailsSection(
                    isSubmitting: _isSubmitting,
                    onSubmit: (String reason) {
                      _submitBooking(reason);
                    },
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
