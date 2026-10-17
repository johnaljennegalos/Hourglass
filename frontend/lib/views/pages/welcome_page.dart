import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hourglass/views/pages/role_selection_page.dart';
import 'package:hourglass/views/pages/login_page.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lotties/hourly.json', height: 320.0, fit: BoxFit.contain,),
                const SizedBox(height: 30.0),
                const Text('Hourglass', style: TextStyle(
                    fontSize: 40.0,
                    letterSpacing: -0.5,
                    color: Color(0xFF2563EB),
                  ),),
                const SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Smarter consultation booking for students and instructors.',
                    style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black54,
                    height: 1.4
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RoleSelectionPage();
                          },),
                      );
                    },
                  label: const Text('Get Started'),
                  icon: Icon(Icons.arrow_forward),
                  iconAlignment: IconAlignment.end,
                  style: FilledButton.styleFrom(
                    minimumSize: Size(double.infinity, 40.0),
                    backgroundColor: Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                    // child: Text('Get Started'),
                ),
                const SizedBox(height: 16.0,),
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return LoginPage();
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
    );
  }
}
