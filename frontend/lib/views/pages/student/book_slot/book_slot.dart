import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/section_header.dart';

class BookSlot extends StatefulWidget {
  const BookSlot({super.key});

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
