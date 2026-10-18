import 'package:flutter/material.dart';
import 'package:hourglass/views/widgets/signin_wave_clipper.dart';
import 'package:flutter/gestures.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: SigninWaveClipper(),
              child: Container(
                height: 250,
                color: const Color(0xFF2563EB),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text('Welcome Back!', style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),),
                    SizedBox(height: 8,),
                    Text('Sign in to you account.', style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: 50.0),
                        TextFormField(
                          // controller: firstNameController,
                          style: const TextStyle(color: Colors.black87),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.verified_user_outlined, color: Color(0xFF2563EB)),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 2.0)
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          // controller: firstNameController,
                          style: const TextStyle(color: Colors.black87),
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.password_outlined, color: Color(0xFF2563EB)),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 2.0)
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        OutlinedButton.icon(
                          onPressed: () async {
                          //   if (_formKey.currentState!.validate()){
                          //
                          //     try{
                          //
                          //       final response = await StudentService.registerStudent(
                          //         firstNameController.text.trim(),
                          //         lastNameController.text.trim(),
                          //         usernameController.text.trim(),
                          //         emailController.text.trim(),
                          //         passwordController.text.trim(),
                          //       );
                          //
                          //       if (response.statusCode == 201 || response.statusCode == 200) {
                          //         if (!mounted) return;
                          //
                          //         setState(() {
                          //           firstNameController.clear();
                          //           lastNameController.clear();
                          //           usernameController.clear();
                          //           emailController.clear();
                          //           passwordController.clear();
                          //         });
                          //
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //             const SnackBar(
                          //               content: Text('Registration successful!'),
                          //               backgroundColor: Colors.green,
                          //             )
                          //         );
                          //
                          //         FocusScope.of(context).unfocus();
                          //
                          //         TODO: Navigate to login screen or home page
                          //         // Navigator.pushReplacement(...);
                          //       } else if (response.statusCode == 400) {
                          //         if (!mounted) return;
                          //
                          //         final Map<String, dynamic> errors = jsonDecode(response.body);
                          //         final String firstError = errors.values.first[0].toString();
                          //
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text('Registration failes $firstError'),
                          //             backgroundColor: Colors.red,
                          //           ),
                          //         );
                          //       } else {
                          //         if (!mounted) return;
                          //
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(
                          //             content: Text('Server error [${response.statusCode}]. Please try again.'),
                          //             backgroundColor: Colors.red,
                          //           ),
                          //         );
                          //       }
                          //
                          //     } catch (e) {
                          //       if (!mounted) return;
                          //
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text('Network error: $e'),
                          //           backgroundColor: Colors.red,
                          //         ),
                          //       );
                          //     }
                          //
                          //   }
                          //
                          //
                          //
                          //   // Navigator.push(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) {
                          //   //       return ();
                          //   //     },
                          //   //   ),
                          //   // );
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
                        Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context){
                                            return SignInPage();
                                          },
                                        )
                                    );
                                  },
                              ),
                            ],
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
      ),
    );
  }
}
