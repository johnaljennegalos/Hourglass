import 'package:flutter/material.dart';

class AccountActions extends StatelessWidget {
  const AccountActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ACCOUNT ACTIONS"),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red,),
                title: Text('Logout'),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.red),
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
