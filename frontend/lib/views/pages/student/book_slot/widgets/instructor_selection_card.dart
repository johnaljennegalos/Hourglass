import 'package:flutter/material.dart';

class InstructorSelectionCard extends StatefulWidget {
  final String searchQuery;
  final ValueChanged<String>? onInstructorSelected;
  const InstructorSelectionCard({super.key, required this.searchQuery, this.onInstructorSelected});

  @override
  State<InstructorSelectionCard> createState() => _InstructorSelectionCardState();
}

class _InstructorSelectionCardState extends State<InstructorSelectionCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

