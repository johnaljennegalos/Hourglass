import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSlot extends StatefulWidget {
  const AddSlot({super.key});

  @override
  State<AddSlot> createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {

  DateTime _dateTime = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _maxCapacity = 1;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime(2027)
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Consultation Slot'),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set the date, time and consultation details'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consultation date', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                TextButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: const Color(0xFF2563EB),
                    side: const BorderSide(color: Colors.black26, width: 1),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text( DateFormat('EEEE, MMMM d, yyyy').format(_dateTime), style: TextStyle(
                        color: Colors.black54
                      ),),
                      Icon(Icons.date_range),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Start time', style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          TextButton(
                            onPressed: () {
                              _selectTime(context);
                            },
                            style: TextButton.styleFrom(
                              // minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: const Color(0xFF2563EB),
                              side: const BorderSide(color: Colors.black26, width: 1),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedTime.format(context), style: TextStyle(
                                    color: Colors.black54
                                ),),
                                Icon(Icons.access_time),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('End time', style: TextStyle(
                              fontWeight: FontWeight.bold,
                          ),),
                          TextButton(
                            onPressed: () {
                              _selectTime(context);
                            },
                            style: TextButton.styleFrom(
                              // minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: const Color(0xFF2563EB),
                              side: const BorderSide(color: Colors.black26, width: 1),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedTime.format(context), style: TextStyle(
                                    color: Colors.black54
                                ),),
                                Icon(Icons.access_time),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Maximum Capacity', style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1.0,
                              ),
                            ),
                            child: DropdownButton<int>(
                                value: _maxCapacity,
                              icon: Icon(Icons.arrow_drop_down),
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              onChanged: (int? newValue){
                                  if (newValue != null) {
                                    setState(() {
                                      _maxCapacity = newValue;
                                    });
                                  }
                              },
                              items: [
                                DropdownMenuItem<int>(
                                    value: 1,
                                    child: Text('One Student')
                                ),
                                DropdownMenuItem<int>(
                                    value: 2,
                                    child: Text('Two Students')
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location', style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              // controller: _locationController,
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'e.g. Room 304 / Zoom',
                                hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                suffixIcon: const Icon(Icons.location_on, color: Color(0xFF2563EB)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Colors.black26, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Color(0xFF1D4ED8), width: 1.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
