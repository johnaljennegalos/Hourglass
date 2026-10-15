import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  String? selectedCourse;
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your account', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF2563EB),
        ),),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Let’s get started!', textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 8.0),
                  Text('Complete the form below to get started.',textAlign: TextAlign.left, style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),),
                  Row(
                    children: [
                      Expanded(
                          child: const TextField(
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                      ),
                      SizedBox(width: 20.0,),
                      Expanded(
                        child: const TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.streetview),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Student ID',
                      prefixIcon: Icon(Icons.numbers),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedCourse,
                            hint: Text('Course'),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.assignment_ind),
                              // border: OutlineInputBorder(),
                            ),
                            items: ['BSCS', 'BSIT'].map((String title) => DropdownMenuItem<String>(
                              value: title,
                              child: Text(title),
                            )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCourse = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a title';
                              }
                              return null;
                            },
                          ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedYear,
                            hint: Text('Year'),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.assignment_ind),
                              // border: OutlineInputBorder(),
                            ),
                            items: ['1', '2', '3', '4'].map((String title) => DropdownMenuItem<String>(
                              value: title,
                              child: Text(title),
                            )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a title';
                              }
                              return null;
                            },
                          ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Section',
                      prefixIcon: Icon(Icons.flight_class_rounded),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email)
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StudentRegistration();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.app_registration, size: 22.0),
                    label: const Text('Register'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      backgroundColor: Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue, width: 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        //register steady button
      ),
    );
  }
}
