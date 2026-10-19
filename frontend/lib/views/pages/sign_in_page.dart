import 'package:flutter/material.dart';
import 'package:hourglass/views/widgets/signin_wave_clipper.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hourglass/views/pages/role_selection_page.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: SigninWaveClipper(),
              child: Container(
                height: 155,
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
                        SizedBox(height: 0.0),
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
                          obscureText: _obscureText,
                          // controller: firstNameController,
                          style: const TextStyle(color: Colors.black87),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.password_outlined, color: Color(0xFF2563EB)),
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Color(0xFF2563EB),
                              ),
                              onPressed: (){
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2563EB), width: 2.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 2.0)
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: ListTileTheme(
                                horizontalTitleGap: 0.0,
                                child: CheckboxListTile(
                                  title: Text('Remember me',     style: TextStyle(
                                    fontSize: 14,
                                  ),),
                                  visualDensity: const VisualDensity(
                                    horizontal: -2,
                                    vertical: -2,
                                  ),
                                  checkboxScaleFactor: 0.8,
                                  value: isChecked,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO
                              },
                              child: Text(
                                'Forgot Password?'
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
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
                          icon: const Icon(Icons.login, size: 22.0),
                          label: const Text('Sign In'),
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
                            text: "Don't have an account yet? ",
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context){
                                            return RoleSelectionPage();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Row(
                children: const [
                  Expanded(child: Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO
                },
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFF2563EB),
                  size: 20.0,
                ),
                label: Text('Sign in with Google'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50.0),
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
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
