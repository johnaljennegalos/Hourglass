  import 'package:flutter/gestures.dart';
  import 'package:flutter/material.dart';
  import 'package:lottie/lottie.dart';
  import 'package:hourglass/views/pages/role_selection_page.dart';
  import 'package:hourglass/views/pages/sign_in_page.dart';
  import 'package:introduction_screen/introduction_screen.dart';


  class WelcomePage extends StatelessWidget {
    const WelcomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie.asset('assets/lotties/hourly.json', height: 320.0, fit: BoxFit.contain,),
                // const SizedBox(height: 30.0),
                // const Text('Hourglass', style: TextStyle(
                //     fontSize: 40.0,
                //     letterSpacing: -0.5,
                //     color: Color(0xFF2563EB),
                //   ),),
                // const SizedBox(height: 10.0),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Text(
                //     'Smarter consultation booking for students and instructors.',
                //     style: TextStyle(
                //     fontWeight: FontWeight.normal,
                //     fontSize: 16.0,
                //     color: Colors.black54,
                //     height: 1.4
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IntroductionScreen(
                      pages: [
                        PageViewModel(
                          image: Center(
                            child: Lottie.asset(
                              'assets/lotties/book-appointment.json',
                              height: 320.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          decoration: const PageDecoration(
                            imageFlex: 2,
                            bodyFlex: 1,
                          ),
                          titleWidget: const Text(
                            'Book consultations easily',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                              height: 1.2,
                            ),
                          ),
                          bodyWidget: const Text(
                            'Find available instructors and schedule consultations that fit your schedule.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        PageViewModel(
                          image: Center(
                            child: Lottie.asset(
                              'assets/lotties/needguidance.json',
                              height: 320.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          decoration: const PageDecoration(
                            imageFlex: 2,
                            bodyFlex: 1,
                          ),
                          titleWidget: const Text(
                            'Get the guidance you need',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                              height: 1.2,
                            ),
                          ),
                          bodyWidget: const Text(
                            'Connect with your instructors and get help with your academic concerns..',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        PageViewModel(
                          image: Center(
                            child: Lottie.asset(
                              'assets/lotties/ontrack.json',
                              height: 320.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          decoration: const PageDecoration(
                            imageFlex: 2,
                            bodyFlex: 1,
                          ),
                          titleWidget: const Text(
                            'Stay on track',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2563EB),
                              height: 1.2,
                            ),
                          ),
                          bodyWidget: const Text(
                            'Manage your consultation requests, schedules, and booking history in one place.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                      showDoneButton: false,
                      showNextButton: false
                    ),
                  ),
                ),
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
      );
    }
  }
