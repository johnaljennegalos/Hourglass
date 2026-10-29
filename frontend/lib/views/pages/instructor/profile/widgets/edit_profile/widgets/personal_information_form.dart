import 'package:flutter/material.dart';
import 'package:profile_lift/profile_lift.dart';


class PersonalInformationForm extends StatefulWidget {
  const PersonalInformationForm({super.key});

  @override
  State<PersonalInformationForm> createState() => _PersonalInformationFormState();
}

class _PersonalInformationFormState extends State<PersonalInformationForm> {
  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Information"),
          TextFormField(
            // controller: emailController,
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
            // controller: firstNameController,
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
            // controller: lastNameController,
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
            // controller: emailController,
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
            // controller: emailController,
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
            // controller: emailController,
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
            // controller: emailController,
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
            onPressed: () {
              //todo
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
