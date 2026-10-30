import 'package:flutter/material.dart';
import 'package:hourglass/services/auth_service.dart';
import 'package:hourglass/views/pages/welcome_page.dart';

class AccountActions extends StatefulWidget {
  const AccountActions({super.key});

  @override
  State<AccountActions> createState() => _AccountActionsState();
}

class _AccountActionsState extends State<AccountActions> {
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
                onTap: () async {
                  await AuthService.logout();

                  if (!mounted) return;

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const WelcomePage()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
