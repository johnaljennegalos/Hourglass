import 'package:flutter/material.dart';
import 'package:profile_lift/profile_lift.dart';
import 'package:hourglass/services/instructor_service.dart';


class PersonalInformationForm extends StatefulWidget {
  final VoidCallback? onSaveSuccess;

  const PersonalInformationForm({super.key, this.onSaveSuccess});

  @override
  State<PersonalInformationForm> createState() => _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDepartment;
  bool isLoading = true;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController employeeIDController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    employeeIDController.dispose();
    specializationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final data = await InstructorService.getProfile();
    if (data != null && mounted) {
      setState(() {
        firstNameController.text = data['first_name'] ?? '';
        lastNameController.text = data['last_name'] ?? '';
        emailController.text = data['email'] ?? '';
        addressController.text = data['address'] ?? '';
        contactNumberController.text = data['contact_number'] ?? '';
        employeeIDController.text = data['employee_id'] ?? '';
        specializationController.text = data['specialization'] ?? '';

        if (['IT', 'CS'].contains(data['department'])) {
          selectedDepartment = data['department'];
        }
        isLoading = false;
      });
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

    final bool isEmployeeIdEditable =
        employeeIDController.text.trim().isEmpty;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Information"),
          TextFormField(
            controller: employeeIDController,
            enabled: isEmployeeIdEditable,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Employee ID',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
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
          value: selectedDepartment,
          style: const TextStyle(color: Colors.black87),
          decoration: const InputDecoration(
            labelText: 'Department',
            labelStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.business_outlined, color: Color(0xFF2563EB)),
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'IT',
              child: Text('Information Technology'),
            ),
            DropdownMenuItem(
              value: 'CS',
              child: Text('Computer Science'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedDepartment = value;
            });
          },
          validator: (value) => (value == null || value.isEmpty) ? 'Please select a department' : null,
        ),
          TextFormField(
            controller: specializationController,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              labelText: 'Specialization',
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF2563EB)),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
              ),
            ),
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
                    'department': selectedDepartment,
                    'specialization': specializationController.text.trim(),
                    'employee_id': employeeIDController.text.trim()
                  };

                  final bool isSuccess = await InstructorService.updateProfile(
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
