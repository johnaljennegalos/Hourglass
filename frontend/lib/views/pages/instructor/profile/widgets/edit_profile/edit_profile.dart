  import 'package:flutter/material.dart';
  import 'package:hourglass/views/pages/instructor/profile/widgets/edit_profile/widgets/personal_information_form.dart';

  class EditProfile extends StatefulWidget {
    const EditProfile({super.key});

    @override
    State<EditProfile> createState() => _EditProfileState();
  }

  class _EditProfileState extends State<EditProfile> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              PersonalInformationForm(onSaveSuccess: () {
                Navigator.pop(context, true);
              },),
            ],
          ),
        ),
      );
    }
  }
