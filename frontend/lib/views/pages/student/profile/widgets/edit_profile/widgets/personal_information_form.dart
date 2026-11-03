import 'package:flutter/material.dart';
import 'package:profile_lift/profile_lift.dart';
import 'package:hourglass/services/student_service.dart';


class PersonalInformationForm extends StatefulWidget {
  final VoidCallback? onSaveSuccess;

  const PersonalInformationForm({super.key, this.onSaveSuccess});

  @override
  State<PersonalInformationForm> createState() => _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController studentIDController = TextEditingController();
  final TextEditingController yearLevelController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    studentIDController.dispose();
    yearLevelController.dispose();
    sectionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  String? selectedCourse;

  final List<dynamic> courseOptions = const [
  {'value': 'BSIT', 'label': 'BS Information Technology'},
  {'value': 'BSCS', 'label': 'BS Computer Science'},
  ];

  Future<void> _loadProfileData() async {
    final data = await StudentService.getProfile();
    if (data != null && mounted) {

      final Map<String, dynamic>? studentData = data['student'];

      if (studentData != null) {
        setState(() {
          firstNameController.text = studentData['first_name'] ?? '';
          lastNameController.text = studentData['last_name'] ?? '';
          emailController.text = studentData['email'] ?? '';
          addressController.text = studentData['address'] ?? '';
          contactNumberController.text = studentData['contact_number'] ?? '';

          studentIDController.text = studentData['student_id'] ?? '';

          yearLevelController.text = studentData['year_level']?.toString() ?? '';
          sectionController.text = studentData['section'] ?? '';

          final String? courseFromApi = studentData['course'];
          if (courseOptions.any((c) => c['value'] == courseFromApi)) {
            selectedCourse = courseFromApi;
          }

          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final bool isStudentIdEditable =
        studentIDController.text.trim().isEmpty;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Information"),
          TextFormField(
            controller: studentIDController,
            enabled: isStudentIdEditable,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Student ID',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: yearLevelController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Year Level',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.format_list_numbered_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: sectionController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Section',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.class_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: firstNameController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'First Name',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.person_outline, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: lastNameController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Last Name',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.person_4_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: emailController,
            enabled: false,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: addressController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Address',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          TextFormField(
            controller: contactNumberController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Contact Number',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedCourse,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Course',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.school_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
            items: courseOptions.map((course) {
              return DropdownMenuItem<String>(
                value: course['value'],
                child: Text(course['label']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCourse = value;
              });
            },
            validator: (value) => (value == null || value.isEmpty) ? 'Please select a course' : null,
          ),
          OutlinedButton.icon(
            onPressed: () async {
              if (_formKey.currentState!.validate()){

                try {
                  final Map<String, dynamic> updateData = {
                    'first_name': firstNameController.text.trim(),
                    'last_name': lastNameController.text.trim(),
                    'address': addressController.text.trim(),
                    'contact_number': contactNumberController.text.trim(),
                    'student_id': studentIDController.text.trim(),
                    'course': selectedCourse,
                    'section': sectionController.text.trim(),
                  };

                  if (yearLevelController.text.trim().isNotEmpty) {
                    final int? parsedYear = int.tryParse(yearLevelController.text.trim());
                    if (parsedYear != null) {
                      updateData['year_level'] = parsedYear;
                    }
                  }

                  if (isStudentIdEditable && studentIDController.text.trim().isNotEmpty) {
                    updateData['student_id'] = studentIDController.text.trim();
                  }

                  final bool isSuccess = await StudentService.updateProfile(
                      updateData);

                  if (!mounted) return;

                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    FocusScope.of(context).unfocus();

                    if (widget.onSaveSuccess != null) {
                      widget.onSaveSuccess!();
                    } else {
                      Navigator.pop(context, true);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Failed to update profile. Please check your entries.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.save, size: 22.0),
            label: const Text('Save Changes'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
              ),
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.blue, width: 1.0),
            ),
          )
        ],
      ),
    );
  }
}
