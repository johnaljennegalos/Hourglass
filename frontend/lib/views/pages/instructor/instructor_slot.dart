import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/slot/add_slot.dart';



class InstructorSlot extends StatefulWidget {
  const InstructorSlot({super.key});

  @override
  State<InstructorSlot> createState() => _InstructorSlotState();
}

class _InstructorSlotState extends State<InstructorSlot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Slots',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Text('Manage your consultation availability')
                      ],
                    )
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return AddSlot();
                            },
                          )
                      );
                    },
                    icon: Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.black26),
                    bottom: BorderSide(width: 2.0, color: Colors.black26),
                    left: BorderSide(width: 2.0, color: Colors.black26),
                    right: BorderSide(width: 2.0, color: Colors.black26),
                  ),
                ),
                child: const Text('Styled Container'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
