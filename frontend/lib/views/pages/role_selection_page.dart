import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hourglass/views/pages/student/student_registration_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.0,),
                Lottie.asset('assets/lotties/role_select.json'),
                SizedBox(height: 10.0),
                Text('Hi, please select your role.', style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black54,
                    height: 1.4
                ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return StudentRegistrationPage();
                            },
                        ),
                    );
                    },
                  icon: const Icon(Icons.school_rounded, size: 22.0),
                  label: const Text('Student'),
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
                SizedBox(height: 20.0),
                OutlinedButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.cast_for_education, color: Colors.black),
                  label: const Text('Instructor', style: TextStyle(color: Colors.black),),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
