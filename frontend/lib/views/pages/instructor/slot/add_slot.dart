import 'package:flutter/material.dart';
import 'package:hourglass/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:hourglass/services/instructor_service.dart';
import 'package:hourglass/services/auth_service.dart';

class AddSlot extends StatefulWidget {
  const AddSlot({super.key, this.slot});

  final Map<String, dynamic>? slot;

  @override
  State<AddSlot> createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  final GlobalKey<ScaffoldMessengerState> _slotMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  DateTime _dateTime = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  int _maxCapacity = 1;
  bool repeatEnabled = false;
  int repeatWeeks = 2;

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dt);
  }

  List<DateTime> getRepeatDates() {
      return List.generate(
        repeatEnabled ? repeatWeeks : 1,
          (index) => _dateTime.add(
        Duration(days: index * 7)
      )
    );
  }

  Future<void> _startTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _endTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }


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
        initialDate: _dateTime,
        firstDate: DateTime(1945),
        lastDate: DateTime(2027)
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.slot != null) {
      final slotData = widget.slot!;

      _locationController.text = slotData['location']?.toString() ?? '';
      _maxCapacity = (slotData['max_capacity'] as int?) ?? 1;

      if (slotData['date'] != null) {
        _dateTime = DateTime.parse(slotData['date'].toString());
      }

      TimeOfDay? parseTimeString(String? timeStr) {
        if (timeStr == null || timeStr.isEmpty) return null;
        final parts = timeStr.split(':');
        if (parts.length > 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour != null && minute != null) {
            return TimeOfDay(hour: hour, minute: minute);
          }
        }
        return null;
      }

      _startTime = parseTimeString(slotData['start_time']?.toString());
      _endTime = parseTimeString(slotData['end_time']?.toString());

    }

  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _slotMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.slot != null ? 'Edit Consultation Slot' : 'Add Consultation Slot'),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Form(
            key: _formKey,
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
                                  _startTimeMethod(context);
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
                                    Text(_startTime?.format(context) ?? 'Select time', style: TextStyle(
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
                                  _endTimeMethod(context);
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
                                    Text(_endTime?.format(context) ?? 'Select time', style: TextStyle(
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
                                  controller: _locationController,
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
                    if (widget.slot == null) ...[
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Repeat Weekly',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Create additional slots on the same weekday for consecutive weeks', style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,)
                              )
                            ],
                          ),
                          Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Repeat this slot',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text('Create additional slots weekly', style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: repeatEnabled,
                                  activeColor: Color(0xFF2563EB),
                                  onChanged: (value) {
                                    setState(() {
                                      repeatEnabled = value;
                                    });
                                  },
                                ),
                              ]
                          ),
                          if (repeatEnabled) ...[
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                const Text(
                                  'Number of weeks',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),

                                const Spacer(),

                                IconButton(
                                  color: Colors.redAccent,
                                  onPressed: repeatWeeks > 2
                                      ? () {
                                    setState(() {
                                      repeatWeeks--;
                                    });
                                  }
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),

                                Text(
                                  '$repeatWeeks',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  color: Color(0xFF2563EB),
                                  onPressed: repeatWeeks < 20
                                      ? () {
                                    setState(() {
                                      repeatWeeks++;
                                    });
                                  }
                                      : null,
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            Text('$repeatWeeks dated slots will be created, one week apart.'),
                          ],
                          if (repeatEnabled) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'Repeat preview',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...getRepeatDates().asMap().entries.map((entry) {
                              final index = entry.key;
                              final date = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 18,
                                      color: Color(0xFF2563EB),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        DateFormat('EEE, MMM d, yyyy').format(date),
                                      ),
                                    ),
                                    Text(
                                      'Week ${index + 1}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                          ],
                        ],
                      ),
                    ],
                    //outline button
                    OutlinedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){

                          try{
                            final DateTime now = DateTime.now();
                            final DateTime today = DateTime(now.year, now.month, now.day);
                            final DateTime selectedDate = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);

                            if (selectedDate.isBefore(today)) {
                              _slotMessengerKey.currentState
                                ?..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Cannot create consultation slots for past dates.',
                                    ),
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              return;
                            }

                            if (_startTime == null || _endTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select both start and end times.'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            if (_locationController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a location.'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            final Map<String, dynamic> slotData = {
                              'date': DateFormat('yyyy-MM-dd').format(_dateTime),
                              'start_time': _formatTimeOfDay(_startTime!),
                              'end_time': _formatTimeOfDay(_endTime!),
                              'max_capacity': _maxCapacity,
                              'location': _locationController.text.trim(),
                              'repeat_weeks': repeatEnabled ? repeatWeeks : 1,
                            };

                            print('Sending Access Token: ${AuthService.accessToken}');

                            if (AuthService.accessToken == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Session expired. Please log in again.'),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            final bool isEditing = widget.slot != null;
                            bool success = false;

                            if (isEditing) {
                              final int slotId = widget.slot!['id'];
                              success = await InstructorService.updateConsultationSlot(slotId, slotData);
                            } else {
                              success = await InstructorService.createConsultationSlot(slotData);
                            }

                            if (!mounted) return;

                            if (success) {
                              _slotMessengerKey.currentState
                                ?..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isEditing
                                          ? 'Consultation slot updated successfully!'
                                          : 'Consultation slot created successfully!',
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                              Navigator.pop(context, true);
                            } else  {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isEditing
                                        ? 'Failed to update slot.'
                                        : 'Failed to create slot. Please check for schedule overlaps.',
                                  ),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }

                          } catch (e) {
                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Network error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ();
                        //     },
                        //   ),
                        // );
                        // TODO
                      },
                      icon: Icon(
                        widget.slot != null ? Icons.save : Icons.event_available,
                        size: 22.0,
                      ),
                      label: Text(widget.slot != null ? 'Save Changes' : 'Create Slot'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        backgroundColor: Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
