import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection_card.dart';
import 'package:hourglass/views/pages/student/book_slot/models/instructor_model.dart';



class InstructorSelection extends StatefulWidget {
  final String searchQuery;
  final String? selectedInstructorId;
  final ValueChanged<String> onInstructorSelected;
  const InstructorSelection({super.key, required this.searchQuery, required this.onInstructorSelected, required this.selectedInstructorId});

  static final List<InstructorModel> _mockInstructors = [
    InstructorModel(
      id: '1234567890',
      name: 'Manny Pacquiao',
      department: 'Computer Science',
      specialization: 'Left Hook Algorithm',
      avatarUrl: null,
    ),
    InstructorModel(
      id: '1',
      name: 'Dr. Jane Smith',
      department: 'College of Computer Studies',
      specialization: 'Web Development',
      avatarUrl: null,
    ),
    InstructorModel(
      id: '2',
      name: 'Prof. John Doe',
      department: 'College of Engineering',
      specialization: 'Data Structures & Algorithms',
      avatarUrl: null,
    ),
  ];

  @override
  State<InstructorSelection> createState() => _InstructorSelectionState();
}

class _InstructorSelectionState extends State<InstructorSelection> {
  @override
  Widget build(BuildContext context) {
    final filteredInstructors = InstructorSelection._mockInstructors.where((instructor) {
      final query = widget.searchQuery.toLowerCase();
      return instructor.name.toLowerCase().contains(query) || instructor.department.toLowerCase().contains(query) || instructor.specialization.toLowerCase().contains(query);
    }).toList();

    if (filteredInstructors.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'No instructors found.',
            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ),
      );
    }


    return Column(
      children: filteredInstructors.map((instructor) {
        final isSelected = instructor.id == widget.selectedInstructorId;
        return Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: InstructorSelectionCard(instructor: instructor, isSelected: isSelected, onTap: () => widget.onInstructorSelected(instructor.id)),
        );
      }).toList(),
    );
  }
}
