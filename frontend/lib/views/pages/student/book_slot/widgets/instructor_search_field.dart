import 'package:flutter/material.dart';

class InstructorSearchField extends StatefulWidget {
  const InstructorSearchField({super.key});

  @override
  State<InstructorSearchField> createState() => _InstructorSearchFieldState();
}

class _InstructorSearchFieldState extends State<InstructorSearchField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIcon: Icon(Icons.search_outlined, color: Colors.grey,),
          labelText: 'Search Instructor...',
          filled: true,
          fillColor: Color(0xFFF8FAFC),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Color(0xFF2563EB),
              width: 2
            )
          )
        ),
      ),
    );
  }
}
