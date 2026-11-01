import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/instructor_selection_card.dart';
import 'package:hourglass/views/pages/student/book_slot/models/instructor_model.dart';
import 'package:http/http.dart' as http;
import 'package:hourglass/services/student_service.dart';



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
  bool _isLoading = false;
  String? _errorMessage;
  List<InstructorModel> _instructors = [];

  @override
  void initState() {
    super.initState();
    _fetchData(widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant InstructorSelection oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.searchQuery != oldWidget.searchQuery) {
      _fetchData(widget.searchQuery);
    }
  }

  Future<void> _fetchData(String query) async {

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try{
      final data = await StudentService.getInstructors(query: query);

      if (mounted) {
        setState(() {
          if (data != null) {
            _instructors = data.map((json) => InstructorModel.fromJson(json as Map<String, dynamic>)).toList();
          } else {
            _errorMessage = 'Failed to load instructors.';
          }
          _isLoading = false;
        });
      }

    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'An error occurred: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(_errorMessage!, style: TextStyle(
            color: Colors.red,
          ),),
        ),
      );
    }

    if (_instructors.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text('No instructors found', style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic
          ),),
        ),
      );
    }


    return Column(
      children: _instructors.map((instructor) {
        final isSelected = instructor.id == widget.selectedInstructorId;
        return Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: InstructorSelectionCard(instructor: instructor, isSelected: isSelected, onTap: () => widget.onInstructorSelected(instructor.id)),
        );
      }).toList(),
    );
  }
}
