import 'package:flutter/material.dart';

class PreferenceSection extends StatelessWidget {
  const PreferenceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("PREFERENCES"),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue,),
                title: Text('Notifications'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //route to edit
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.security, color: Colors.blue,),
                title: Text('Security & Password'),
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
