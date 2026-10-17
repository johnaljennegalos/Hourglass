import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hourglass/services/instructor_service.dart';

class InstructorRegistrationPage extends StatefulWidget {
  const InstructorRegistrationPage({super.key});

  @override
  State<InstructorRegistrationPage> createState() => _InstructorRegistrationPageState();
}

class _InstructorRegistrationPageState extends State<InstructorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF2563EB)),
        leading: BackButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Let’s get started!',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Complete the form below to get started with your instructor account.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF2563EB),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: firstNameController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70, width: 2.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: lastNameController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.person_4_outlined, color: Colors.white),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 2.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.white),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 2.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 2.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white60,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                          border: UnderlineInputBorder(),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70, width: 2.0)
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      OutlinedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){

                            try{

                              final response = await InstructorService.registerInstructor(
                                firstNameController.text.trim(),
                                lastNameController.text.trim(),
                                usernameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              if (response.statusCode == 201 || response.statusCode == 200) {
                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registration successful!'),
                                      backgroundColor: Colors.green,
                                    )
                                );

                                // TODO: Navigate to login screen or home page
                                // Navigator.pushReplacement(...);
                              } else if (response.statusCode == 400) {
                                if (!mounted) return;

                                final Map<String, dynamic> errors = jsonDecode(response.body);
                                final String firstError = errors.values.first[0].toString();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Registration failes $firstError'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Server error [${response.statusCode}]. Please try again.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                            } catch (e) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Network error: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                          }



                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return ();
                          //     },
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.app_registration, size: 22.0),
                        label: const Text('Register'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2563EB),
                          side: const BorderSide(color: Colors.blue, width: 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
