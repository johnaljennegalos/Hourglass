import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/profile_header.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/account_section.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/preference_section.dart';

class InstructorProfile extends StatefulWidget {
  const InstructorProfile({super.key});

  @override
  State<InstructorProfile> createState() => _InstructorProfileState();
}

class _InstructorProfileState extends State<InstructorProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(),
                SizedBox(height: 10,),
                AccountSection(),
                SizedBox(height: 10,),
                PreferenceSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
