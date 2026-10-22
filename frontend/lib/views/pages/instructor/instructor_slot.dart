import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'My Consultation Slots',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),
              ),
              SizedBox(height: 8.0,),
              Text('Manage your recurring availability for student consultations.'),
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
