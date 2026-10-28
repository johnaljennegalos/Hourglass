import 'package:flutter/material.dart';

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
                leading: Icon(Icons.person),
                title: Text('Edit Profile'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //route to edit
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Manage Availability Slots'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //route to edit
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.history),
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
