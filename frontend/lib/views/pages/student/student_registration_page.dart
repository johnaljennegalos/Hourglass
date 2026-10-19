import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hourglass/services/student_service.dart';
import 'package:hourglass/views/pages/role_selection_page.dart';
import 'package:hourglass/views/pages/sign_in_page.dart';


class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});


  @override
  State<StudentRegistrationPage> createState() => _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
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
        // actions: [
        //   Center(
        //     child: Text('Already have an account?',
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 12.0
        //     ),
        //     ),
        //   ),
        //   TextButton(
        //     style: TextButton.styleFrom(
        //       padding: const EdgeInsets.only(left: 4, right: 20),
        //       minimumSize: Size.zero,
        //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //     ),
        //     onPressed: () {
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const SignInPage(),
        //         ),
        //       );
        //     },
        //     child: Text('Sign In', style: TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 14.0
        //     ),),
        //   )
        // ],
        backgroundColor: Color(0xFF2563EB),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
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
            color: Color(0xFF2563EB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Let’s get started!',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Complete the form below to get started with your student account.',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23)
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Form(
                    key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 00.0),
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
                          SizedBox(height: 20.0),
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
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: usernameController,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.account_circle_outlined, color: Color(0xFF2563EB)),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: emailController,
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
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: passwordController,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF2563EB)),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          OutlinedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()){

                                try{

                                  final response = await StudentService.registerStudent(
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim(),
                                    usernameController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                                  if (response.statusCode == 201 || response.statusCode == 200) {
                                    if (!mounted) return;

                                    setState(() {
                                      firstNameController.clear();
                                      lastNameController.clear();
                                      usernameController.clear();
                                      emailController.clear();
                                      passwordController.clear();
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Registration successful! Redirecting to Sign In...'),
                                        backgroundColor: Colors.green,
                                      )
                                    );

                                    FocusScope.of(context).unfocus();

                                    await Future.delayed(const Duration(seconds: 4));

                                    // TODO: Navigate to login screen or home page
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignInPage(),
                                      ),
                                      (route) => route.isFirst,
                                    );
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
                              backgroundColor: Color(0xFF2563EB),
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.blue, width: 1.0),
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context){
                                                return SignInPage();
                                              },
                                            ),
                                            (route) => route.isFirst,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
