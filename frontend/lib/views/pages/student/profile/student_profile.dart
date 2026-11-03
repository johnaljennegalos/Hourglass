import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/profile/widgets/profile_header.dart';


class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  Key _headerKey = UniqueKey();

  void _refreshProfile() {
    setState(() {
      _headerKey = UniqueKey();
    });
  }

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
                ProfileHeader(key: _headerKey,),
                SizedBox(height: 10,),
                // AccountSection(onProfileUpdated: _refreshProfile),
                // SizedBox(height: 10,),
                // PreferenceSection(),
                // SizedBox(height: 10,),
                // AccountActions()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
