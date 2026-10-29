import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/edit_profile/edit_profile.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ACCOUNT"),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.blue,),
                title: Text('Edit Profile'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.blue,),
                title: Text('Manage Availability Slots'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //route to edit
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.history, color: Colors.blue,),
                title: Text('Consultation History'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //route to edit
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
