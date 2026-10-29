import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/edit_profile/edit_profile.dart';
import 'package:hourglass/views/pages/instructor/instructor_slot.dart';
import 'package:hourglass/views/pages/instructor/profile/widgets/manage_slot/manage_availability_slot.dart';

class AccountSection extends StatelessWidget {
  final VoidCallback? onProfileUpdated;
  const AccountSection({super.key, this.onProfileUpdated});

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
                onTap: () async{
                  final bool? refreshed = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    )
                  );

                  if (refreshed == true && onProfileUpdated != null) {
                    onProfileUpdated!();
                  }
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.blue,),
                title: Text('Manage Availability Slots'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => ManageAvailabilitySlot())
                  );
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
