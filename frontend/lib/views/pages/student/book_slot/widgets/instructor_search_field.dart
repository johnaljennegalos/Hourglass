import 'package:flutter/material.dart';
import 'dart:async';

class InstructorSearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const InstructorSearchField({super.key, required this.onChanged});

  @override
  State<InstructorSearchField> createState() => _InstructorSearchFieldState();
}

class _InstructorSearchFieldState extends State<InstructorSearchField> {
  final TextEditingController _searchInputController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: _searchInputController,
        onChanged: (text) {
          if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

          _debounceTimer = Timer(const Duration(milliseconds: 400), () {
            widget.onChanged(text);
          });
        },
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
